# RickAndMortyApp

Sample iOS application to display 'Rick And Morty' Characters and Episodes information developed in swift.

An implementation of the MVVM + Clean architecture (Swift).

## Motivation
Having an example project, for reference.

### Requirements
 - MVVM
 - Testability
 - Code Organization
 - Code Reusability
 - Characters Search
 - Images Cache

 
## Patterns
This project uses different patterns for its implementation, in a classic clean architecture.

- Presentation for view layer (MVVM pattern).
- Domain for business logic layer.
- Data for data layer (Repos, CoreData, Local Files…)

### Coordinator 
Its responsibility is to show a new view, in this way we free the viewModel from managing the views and we also centralize them all by scenes.

### Boxing
Its responsibility is to bind the view Model properties to view.

### MVVM
Presentation Pattern.

### Dependency injection.
Implementation of dependency injection to simplify testing.


## Testing
UnitTest and UITest have been included with a coverage of more than 90% of the project

![image_testing](https://drive.google.com/uc?export=view&id=1Jeovsl86KwLygDVVBHc8H-Y-P4KKQDAK)


## App Image References

- Characters Operative:

![Characters](https://user-images.githubusercontent.com/39565776/218445529-69276fa1-096b-4cdd-8b94-c49eda9347e9.png)

- Episodes Operative:

![Episodes](https://user-images.githubusercontent.com/39565776/218445518-3558a79b-4d24-40bc-86e1-4ad4d5f22716.png)

- Characters Search and Empty State:

https://user-images.githubusercontent.com/39565776/218445941-5b20facf-df7a-4c49-96ad-f4f2f920d032.mp4


