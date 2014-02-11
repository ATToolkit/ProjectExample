# Creating a project

If you're starting a new project, starting it with an empty root commit can be (in rare circumstances) useful.
```
% git init
% git commit --allow-empty -m "Empty root commit"
```

```
% git subtree add --prefix Tools git@github.com:ATToolkit/Tools.git master --squash
% git subtree add --prefix Libraries/Vendor git@github.com:ATToolkit/Vendor.git master --squash
% git subtree add --prefix Libraries/Base git@github.com:ATToolkit/Base.git master --squash
% git subtree add --prefix Libraries/Animation git@github.com:ATToolkit/Animation.git master --squash
% git subtree add --prefix Applications/AnimationExample git@github.com:ATToolkit/AnimationExample.git master --squash
% cp Tools/examples/_clang-format.example _clang-format
% cp Tools/examples/_projects.example _projects
% cp Tools/examples/gitignore.example .gitignore
```

# Opening the project

```
open Applications/AnimationExample/ATAnimationKitExample.xcworkspace
```

# Formatting + sorting the projects

```
% Tools/ptool _projects
```

# Upstreaming changes

```
% git subtree push --prefix Tools git@github.com:ATToolkit/Tools.git master
% git push origin master
```
