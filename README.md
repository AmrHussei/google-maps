# Google Maps

 Map app using Google Map API that supports registration using phone number , Supports determining the current location and location suggestions (Place Autocomplete)  and determining directions

## Used Tools
- Flutter  
- Dart
- BloC
- Postman
- Google Maps


## Features & Screens
- current location
- Place Autocomplete
- Directions
- Register Screen
- OTP Screen
- Map Screen

## Screenshots
![Screenshot 2023-03-06 174324](https://user-images.githubusercontent.com/94804979/223162031-d1e8dc68-54fd-40d1-9581-e123b22b6bd1.png)
![Screenshot 2023-03-06 174415](https://user-images.githubusercontent.com/94804979/223162055-04217339-85c9-4fd7-9b88-74ebc8c0b683.png)
![Screenshot 2023-03-06 174459](https://user-images.githubusercontent.com/94804979/223162092-14311623-8631-4895-99cb-6f272eba3ab5.png)
![Screenshot 2023-03-06 174549](https://user-images.githubusercontent.com/94804979/223162110-a7e112cc-617e-4beb-9cb6-37139235bc5c.png)
![Screenshot 2023-03-06 174617](https://user-images.githubusercontent.com/94804979/223162158-c14ff0c1-e78d-420d-8c41-3e8b0f64f500.png)
![Screenshot 2023-03-06 175541](https://user-images.githubusercontent.com/94804979/223162678-0947af36-143f-44bc-931a-abf1dc4bfee7.png)




## Color Reference

| Color             |Hex                                                                |
| ----------------- | ------------------------------------------------------------------ |
| blue | #0666EB|
| lightBlue | #E5EFFD |
| lightGreey | #E1E1E1 |



## API Reference 
## Base URL https://maps.googleapis.com/maps/api/


#### Suggestions Request

```http
  GET place/autocomplete/json 
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `sessiontoken` | `string` |  
| `key` | `string` | 
| `components` | `string` | 
| `types` | `string` | 
| `input` | `string` | 

#### For place Location

```http
  GET place/details/json
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `sessiontoken` | `string` |  
| `key` | `string` | 
| `fields` | `string` | 
| `place_id` | `string` | 


#### directions Request

```http
  GET directions/json
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `sessiontoken` | `string` |  
| `key` | `string` | 
| `destination` | `string` | 
| `origin` | `string` | 



## Packages
![aaaaa](https://user-images.githubusercontent.com/94804979/223155878-d9f5c99f-84ee-4cd6-9e33-63b400aa0ba3.png)



## Feedback
If you have any feedback, please reach out to me at amr.flutter.dev@gmail.com

## You can follow me on 
<a href="https://www.linkedin.com/in/amr-hussein-51a141220/">
         <img alt="Qries" src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white"
         >
         
    
### Also You can contact  me 
```http
  020 102 854 4373
```

reference.
