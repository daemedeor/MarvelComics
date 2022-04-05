Project Overview

The project is connecting to the MarvelAPI and pull a list of comics. After pulling them from the Marvel API, I display them in a simple list. This is to keep a focus on the architecture of the app and not to distract too much from the feel. There is a simple loading screen while the data is loading and then will update when there's more data to add. This is so the customer doesn't get lost that data is loading in a slow networking environment.

Architecture Used

I tried to focus on a MVVM architecture though kept the datasource on the main View Controller for ease. There are alternative  architectures that are cleaner but allows deeper conversation about encapsulation, KVO, MVVM, and async/awaits patterns to occur. I focused on trying to encourage testing of the different components and flexibility in definitions.


Packages used

None. I went for no 3rd party libraries to both help for security but also other things. 

Drawbacks

To ensure I timed the amount of work right, I only did a small subsect of functionality. Some key features that I have not got around to is smoother reloading, no error states or warnings,  and cleaner loading states. Also, I included the private key as part of the package. Ideally, this is included during a CI build phase to keep it secret and pulled in only for those who need to know. 