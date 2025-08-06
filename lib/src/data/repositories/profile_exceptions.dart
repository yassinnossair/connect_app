// lib/src/data/repositories/profile_exceptions.dart

/// Thrown when fetching a user profile fails.
class GetProfileFailure implements Exception {}

/// Thrown when updating a user profile fails.
class UpdateProfileFailure implements Exception {}

// NEW: Thrown when uploading a profile picture fails.
class UploadProfilePictureFailure implements Exception {}