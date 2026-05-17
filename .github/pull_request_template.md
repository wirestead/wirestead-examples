## Description
<!-- Provide a brief summary of the changes and the motivation behind them. -->

## Key Changes
<!-- List the specific modifications made in this PR. -->
- 
- 

## Related Issues
<!-- Link any related issues using keywords like "Fixes #123" or "Closes #456". -->
- Fixes #

## Type of Change
<!-- Please mark the relevant option(s) with an "x". -->
- [ ] **Bug Fix**: A non-breaking change that resolves an issue.
- [ ] **Example Update**: Changes to example source code or behavior.
- [ ] **Build/CI**: Changes to CMake, vcpkg, formatting, or workflow files.
- [ ] **Documentation**: Changes to documentation only.
- [ ] **Refactor**: Code changes that neither fix a bug nor add functionality.
- [ ] **Testing**: Adding or updating validation coverage.

## Validation
<!-- Check the items that apply, and note any skipped checks in Additional Context. -->
- [ ] I have run `git diff --check`.
- [ ] I have run the FetchContent build:
      `cmake -S . -B build -DUNILINK_EXAMPLES_USE_FETCHCONTENT=ON`
      and `cmake --build build --parallel`.
- [ ] I have run the vcpkg build:
      `cmake -S . -B build-vcpkg -DUNILINK_EXAMPLES_USE_FETCHCONTENT=OFF -DCMAKE_TOOLCHAIN_FILE=$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake`
      and `cmake --build build-vcpkg --parallel`.
- [ ] I have run or confirmed formatting checks for C++ and CMake files.
- [ ] I have updated documentation to reflect the change, if applicable.

## Additional Context
<!-- Add any other relevant information, screenshots, logs, or follow-up notes here. -->
