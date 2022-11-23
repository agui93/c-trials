# README

Experiments for `cmake`

# Commands

Common Commands
```
mkdir cmake-build
cd cmake-build
cmake ../
cmake --build .
```

Install Commands
```
cmake --install .
cmake --install . --prefix "/path/to/installdir"
```

Test Commands
```
ctest -N
ctest -VV
ctest -C Debug -VV
ctest -C Release -VV
```


# Step By Step

| step                    |        function   |
| ----------------------- | --------------------- |
| [step1](./steps/step1)  |  Without cmake       |
| [step2](./steps/step2)  |  Basic               |
| [step3](./steps/step3)  |  Add a static library |
| [step4](./steps/step4)  |  Add a library     |
| [step5](./steps/step4)  |  Install and test     |
| [step6](./steps/step4)  |  Add System Introspection     |
| [step7](./steps/step4)  |  Custom Command and Generated File  |
| [step8](./steps/step4)  |  Packaging an Installer     |
| [step9](./steps/step4)  |  Packaging an Installer     |
| [step10](./steps/step4) |  Selecting Static or Shared Libraries  |
| [step11](./steps/step4) |  Adding Generator Expressions     |
| [step12](./steps/step4) |  Adding Export Configuration     |







