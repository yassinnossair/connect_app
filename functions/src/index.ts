import * as functions from "firebase-functions/v2/https";
import * as admin from "firebase-admin";

admin.initializeApp();
const db = admin.firestore();

// This is the main function for accepting requests
export const acceptRequest = functions.onCall(async (request) => {
  if (!request.auth) {
    throw new functions.HttpsError(
        "unauthenticated",
        "The function must be called while authenticated.",
    );
  }

  const requestId = request.data.requestId;
  const receiverId = request.auth.uid;

  const requestRef = db.collection("connection_requests").doc(requestId);
  const requestDoc = await requestRef.get();

  if (!requestDoc.exists || requestDoc.data()?.toUserId !== receiverId) {
    throw new functions.HttpsError(
        "not-found", "Request not found or you are not the receiver.",
    );
  }
  const connectionRequest = requestDoc.data()!;
  const senderId = connectionRequest.fromUserId;

  const senderProfileSnap = await db.collection("users").doc(senderId)
      .collection("profiles").limit(1).get();
  const receiverProfileSnap = await db.collection("users").doc(receiverId)
      .collection("profiles").limit(1).get();

  if (receiverProfileSnap.empty) {
    throw new functions.HttpsError(
        "failed-precondition", "Current user (receiver) has no profile.",
    );
  }
  const receiverProfile = receiverProfileSnap.docs[0].data();

  const senderName = senderProfileSnap.empty ?
    connectionRequest.fromUserName : senderProfileSnap.docs[0].data().name;
  const senderPic = senderProfileSnap.empty ?
    connectionRequest.fromUserProfilePictureUrl :
    senderProfileSnap.docs[0].data().profilePictureUrl;

  const now = new Date();
  const connectionId = `${senderId}_${receiverId}`;

  const connectionForSender = {
    id: connectionId,
    userIds: [senderId, receiverId],
    otherUserId: receiverId,
    otherUserName: receiverProfile.name,
    otherUserProfilePictureUrl: receiverProfile.profilePictureUrl,
    connectedAt: now,
  };

  const connectionForReceiver = {
    id: connectionId,
    userIds: [senderId, receiverId],
    otherUserId: senderId,
    otherUserName: senderName,
    otherUserProfilePictureUrl: senderPic,
    connectedAt: now,
  };

  const batch = db.batch();

  const senderConnRef = db.collection("users").doc(senderId)
      .collection("connections").doc(connectionId);
  batch.set(senderConnRef, connectionForSender);

  const receiverConnRef = db.collection("users").doc(receiverId)
      .collection("connections").doc(connectionId);
  batch.set(receiverConnRef, connectionForReceiver);

  batch.update(requestRef, {status: "accepted"});

  await batch.commit();

  return {status: "success", message: "Connection created!"};
});