import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saikai/constant/color_pallete.dart';
import 'package:saikai/constant/util.dart';
import 'package:saikai/model/recipe.dart';
import 'package:saikai/presentation/controller/add_edit_controller.dart';
import 'package:saikai/presentation/controller/auth_controller.dart';

class AddEditRecipe extends StatelessWidget {
  final Recipe recipe;
  final AuthController authController = Get.find(tag: "ac");
  final AddEditController addEditController = Get.put(AddEditController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final currentStep = TextEditingController();
  final currentingredients = TextEditingController();
  AddEditRecipe({Key key, this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    addEditController.setData(recipe);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          recipe == null ? 'add recipe' : recipe.title,
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ListView(
          children: [
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  Obx(
                    () => Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        decoration: createInputDecoration(
                          label: "name",
                          prefixIcon: Icon(
                            Icons.texture,
                          ),
                        ),
                        initialValue: addEditController.title.value,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'name of recipe cannot be null';
                          }
                          return null;
                        },
                        onChanged: (String val) {
                          addEditController.title.value = val;
                        },
                      ),
                    ),
                  ),
                  Obx(
                    () => Container(
                      child: Column(
                        children: [
                          MaterialButton(
                            onPressed: () async {
                              var isGallery = await Get.dialog<bool>(
                                AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('select source image :'),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.image,
                                            ),
                                            onPressed: () =>
                                                Navigator.of(context).pop(
                                              true,
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.camera_alt,
                                            ),
                                            onPressed: () =>
                                                Navigator.of(context).pop(
                                              false,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                              if (isGallery != null) {
                                final picker = ImagePicker();
                                var pickedPhoto = await picker.getImage(
                                    source: isGallery
                                        ? ImageSource.gallery
                                        : ImageSource.camera);
                                addEditController.image.value =
                                    File(pickedPhoto.path);
                              }
                            },
                            child: Row(
                              children: recipe?.foto != null
                                  ? [
                                      Icon(Icons.photo),
                                      Padding(
                                        padding: EdgeInsets.all(
                                          5,
                                        ),
                                      ),
                                      Text("change photo")
                                    ]
                                  : [
                                      Icon(Icons.add_a_photo_outlined),
                                      Padding(
                                        padding: EdgeInsets.all(
                                          5,
                                        ),
                                      ),
                                      Text("add photo")
                                    ],
                            ),
                          ),
                          addEditController.image.value != null
                              ? SizedBox(
                                  width: Get.width * 0.8,
                                  height: Get.width * 0.8,
                                  child: Image.file(
                                    addEditController.image.value,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : addEditController.isEdit.value
                                  ? SizedBox(
                                      width: Get.width * 0.8,
                                      height: Get.width * 0.8,
                                      child: Image.network(
                                        recipe.urlPhoto,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : SizedBox()
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () => addEditController.categories.length < 1
                        ? SizedBox(
                            height: 10,
                            width: 10,
                            child: CircularProgressIndicator(),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField<String>(
                              autovalidateMode: AutovalidateMode.always,
                              value: "1",
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'please select a category';
                                }
                                return null;
                              },
                              items: addEditController.categories
                                  .map<DropdownMenuItem<String>>(
                                    (e) => DropdownMenuItem<String>(
                                      value: e.idCategory,
                                      child: Text(e.category ?? ''),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (val) {
                                addEditController.idCategory.value = val;
                              },
                            ),
                          ),
                  ),
                  Obx(
                    () => AspectRatio(
                      aspectRatio: 3.5 / 1,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: TextFormField(
                          decoration: createInputDecoration(
                            label: "total time (minutes)",
                            prefixIcon: Icon(
                              Icons.texture,
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          initialValue: addEditController.totalTime.value,
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'cannot be null';
                            } else if ((int.tryParse(val) ?? 0) < 1) {
                              return 'cannot less then 1';
                            }
                            return null;
                          },
                          onChanged: (String val) {
                            addEditController.totalTime.value = val;
                          },
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => AspectRatio(
                      aspectRatio: 3.5 / 1,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: TextFormField(
                          decoration: createInputDecoration(
                            label: "servings (person)",
                            prefixIcon: Icon(
                              Icons.texture,
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          initialValue: addEditController.servings.value,
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'cannot be null';
                            } else if ((int.tryParse(val) ?? 0) < 1) {
                              return 'cannot less then 1';
                            }
                            return null;
                          },
                          onChanged: (String val) {
                            addEditController.servings.value = val;
                          },
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Ingredients',
                      ),
                    ],
                  ),
                  Obx(
                    () => Container(
                      child: Column(
                        children: _buildIngredientssForm(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: currentingredients,
                            decoration: createInputDecoration(
                              label: "add ingredients",
                              prefixIcon: Icon(
                                Icons.texture,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add_circle_outline),
                          onPressed: () {
                            addEditController.ingredients
                                .add(currentingredients.text);
                            currentingredients.text = "";
                          },
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Steps',
                      ),
                    ],
                  ),
                  Obx(
                    () => Container(
                      child: Column(
                        children: _buildStepsForm(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: currentStep,
                            decoration: createInputDecoration(
                              label: "add steps",
                              prefixIcon: Icon(
                                Icons.texture,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add_circle_outline),
                          onPressed: () {
                            addEditController.steps.add(currentStep.text);
                            currentStep.text = "";
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: FlatButton(
            color: Get.theme.primaryColor,
            onPressed: () {
              if (formKey.currentState.validate()) {
                addEditController.saveRecipe(
                  authController.uid.toString(),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.save_outlined,
                    color: ColorPallete.mainWhite,
                  ),
                  Text(
                    'Save',
                    style: Get.textTheme.bodyText1
                        .copyWith(color: ColorPallete.mainWhite),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildStepsForm() {
    var stepsForm = <Widget>[];
    List<String> steps = addEditController.steps;
    steps.asMap().forEach(
      (key, value) {
        var form = Container(
          padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: TextFormField(
                    decoration: createInputDecoration(
                      label: "",
                      prefixIcon: Icon(
                        Icons.texture,
                      ),
                    ),
                    onChanged: (val) {
                      addEditController.steps[key] = val;
                    },
                    initialValue: value,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                ),
                onPressed: () => addEditController.steps.removeAt(
                  key,
                ),
              )
            ],
          ),
        );
        stepsForm.add(form);
      },
    );
    return stepsForm;
  }

  List<Widget> _buildIngredientssForm() {
    var ingredientsForm = <Widget>[];
    List<String> ingredients = addEditController.ingredients;
    ingredients.asMap().forEach(
      (key, value) {
        var form = Container(
          padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: TextFormField(
                    decoration: createInputDecoration(
                      label: "",
                      prefixIcon: Icon(
                        Icons.texture,
                      ),
                    ),
                    onChanged: (val) {
                      addEditController.ingredients[key] = val;
                    },
                    initialValue: value,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                ),
                onPressed: () => addEditController.ingredients.removeAt(
                  key,
                ),
              )
            ],
          ),
        );
        ingredientsForm.add(form);
      },
    );
    return ingredientsForm;
  }
}
