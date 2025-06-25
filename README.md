# TixMe - Movie Ticket Booking App

A Flutter application for movie ticket booking with movie management features.

## Features

- **Dashboard**: Browse movies with carousel and movie list
- **Movie Details**: View detailed information about movies
- **Ticket Booking**: Purchase movie tickets
- **Movie Management**: Add new movies with image upload
- **User Authentication**: Login and registration system
- **Profile Management**: User profile features

## New Features Added

### Movie Form (`TambahDataMovie`)

- **Image Picker**: Select movie posters from gallery
- **Form Fields**: Title, description, genre, director, writer, and status
- **Base64 Conversion**: Automatically converts images to base64 for API
- **API Integration**: Sends movie data to backend service
- **Validation**: Form validation with error handling
- **Loading States**: Shows loading indicator during submission

### API Service (`MovieService`)

- **Add Movie**: POST request to add new movie data
- **Error Handling**: Comprehensive error handling for API responses
- **Token Support**: Optional authentication token support

## Getting Started

1. **Install Dependencies**:

   ```bash
   flutter pub get
   ```

2. **Run the App**:

   ```bash
   flutter run
   ```

3. **Access Movie Form**:
   - Navigate to the dashboard
   - Tap the floating action button (+ icon)
   - Fill in the movie details and select an image
   - Submit the form

## Dependencies

- `image_picker: ^1.0.7` - For image selection from gallery
- `http: ^1.4.0` - For API requests
- `carousel_slider: ^5.1.1` - For image carousel
- `shared_preferences: ^2.5.3` - For local storage

## API Endpoints

- **Base URL**: `https://appbioskop.mobileprojp.com/api`
- **Add Movie**: `POST /films`
- **Login**: `POST /login`
- **Register**: `POST /register`

## Form Structure

The movie form accepts the following JSON structure:

```json
{
  "title": "Movie Title",
  "description": "Movie Description",
  "genre": "Movie Genre",
  "director": "Director Name",
  "writer": "Writer Name",
  "stats": "Now Showing",
  "image_base64": "data:image/png;base64,..."
}
```

## Permissions

The app requires the following Android permissions:

- `READ_EXTERNAL_STORAGE` - For accessing gallery images
- `WRITE_EXTERNAL_STORAGE` - For saving images
- `CAMERA` - For taking photos (future feature)

## Color Scheme

- **Primary Color**: `#1a2c4f` (Dark Blue)
- **Secondary Color**: `#fdc001` (Yellow)
- **Accent Color**: `#54647a` (Gray)
- **Text Color**: `#FFFFFF` (White)
