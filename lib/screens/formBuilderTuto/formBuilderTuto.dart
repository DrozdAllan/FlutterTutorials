import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

class FormBuilderTuto extends StatefulWidget {
  const FormBuilderTuto({Key? key}) : super(key: key);

  static const routeName = '/formBuilderTuto';

  @override
  State<FormBuilderTuto> createState() => _FormBuilderTutoState();
}

// list of tabs in the dot_navigation_bar to enum (= const declaration with index)
enum _SelectedTab { home, favorite, search, person }

class _FormBuilderTutoState extends State<FormBuilderTuto> {
  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // true to show the body behind the navbar
      extendBody: true,
      appBar: AppBar(
        title: Text('All you can do with flutter_form_builder'),
      ),
      body: ListView(
        children: [
          Text(
              'Very useful package to display form in many fields, added dot_navigation_bar'),
          Container(
            padding: EdgeInsets.all(12.0),
            child: FormBuilderWidget(),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 10),
        // to use with an IndexedStack widget
        child: DotNavigationBar(
          // enableFloatingNavbar to get a round navbar with padding
          enableFloatingNavBar: true,
          margin: EdgeInsets.only(left: 10, right: 10),
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          dotIndicatorColor: Color.fromRGBO(250, 212, 64, 1.0),
          unselectedItemColor: Colors.grey[300],
          backgroundColor: Colors.white,
          borderRadius: 10,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              //   offset: Offset(10, 10),
              spreadRadius: 1.0,
              // blurRadius: 1.5
            ),
          ],
          onTap: _handleIndexChanged,
          items: [
            /// Home
            DotNavigationBarItem(
              icon: Icon(Icons.home),
              selectedColor: Color(0xff73544C),
            ),

            /// Likes
            DotNavigationBarItem(
              icon: Icon(Icons.favorite),
              selectedColor: Color(0xff73544C),
            ),

            /// Search
            DotNavigationBarItem(
              icon: Icon(Icons.search),
              selectedColor: Color(0xff73544C),
            ),

            /// Profile
            DotNavigationBarItem(
              icon: Icon(Icons.person),
              selectedColor: Color(0xff73544C),
            ),
          ],
        ),
      ),
    );
  }
}

class FormBuilderWidget extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  final options = ["Option 1", "Option 2", "Option 3"];
  final bool isSignIn = true;

  @override
  Widget build(BuildContext context) {
    List genderOptions = ['male', 'female'];

    return Column(
      children: <Widget>[
        FormBuilder(
          key: _formKey,
          // always : already displays errors (works only inside each Fields of the form, not in FormBuilder)
          // disabled : only show errors when trying to validate the form (on submit)
          // onUserInteraction : display all errors as soon as the user enter any field of the form
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              // apply a conditionnal on an element of a list
              if (isSignIn == true)
                FormBuilderTextField(
                  name: 'textfield',
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text('TextField with obscureText and eye to see'),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.equal(context, 'anniewonkie',
                        errorText: 'you must be a annie wonkie')
                  ]),
                ),
              FormBuilderCheckbox(
                name: 'accept_terms',
                decoration: InputDecoration(labelText: 'Checkbox'),
                // add tristate to accept null
                // tristate: true,
                initialValue: false,
                onChanged: _onChanged,
                title: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'I accept the terms',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                validator: FormBuilderValidators.equal(
                  context,
                  true,
                  errorText: 'You must accept terms and conditions to continue',
                ),
              ),
              FormBuilderSwitch(name: 'switch', title: Text('switch')),
              FormBuilderSegmentedControl(
                  name: 'segmented_control',
                  decoration: InputDecoration(labelText: 'SegmentedControl'),
                  options: [
                    FormBuilderFieldOption(
                      value: 'Zaza',
                      child: Text('Zaza'),
                    ),
                    FormBuilderFieldOption(
                      value: 'Zozo',
                      child: Text('Zozo'),
                    ),
                  ]),
              FormBuilderRadioGroup(
                  name: 'radio_group',
                  decoration: InputDecoration(labelText: 'RadioGroup'),
                  options: [
                    FormBuilderFieldOption(
                      value: 'Zaza',
                      child: Text('Zaza'),
                    ),
                    FormBuilderFieldOption(
                      value: 'Zozo',
                      child: Text('Zozo'),
                    ),
                  ]),
              FormBuilderCheckboxGroup(
                  name: 'checkbox_group',
                  decoration: InputDecoration(labelText: 'CheckboxGroup'),
                  options: [
                    FormBuilderFieldOption(
                      value: 'Zinzin',
                      child: Text('Zinzin'),
                    ),
                    FormBuilderFieldOption(
                      value: 'Zouzou',
                      child: Text('Zouzou'),
                    ),
                  ]),
              FormBuilderFilterChip(
                name: 'filter_chip',
                decoration: InputDecoration(
                  labelText: 'FilterChip',
                ),
                options: [
                  FormBuilderFieldOption(
                      value: 'Test 1', child: Text('Test 1')),
                  FormBuilderFieldOption(
                      value: 'Test 2', child: Text('Test 2')),
                ],
              ),
              FormBuilderChoiceChip(
                name: 'choice_chip',
                decoration: InputDecoration(
                  labelText: 'ChoiceChip',
                ),
                options: [
                  FormBuilderFieldOption(
                      value: 'Test 1', child: Text('Test 1')),
                  FormBuilderFieldOption(
                      value: 'Test 2', child: Text('Test 2')),
                ],
              ),
              FormBuilderDateTimePicker(
                name: 'date',
                // onChanged: _onChanged,
                inputType: InputType.both,
                // or InputType.time or InputType.date
                decoration: InputDecoration(
                  labelText: 'DateTimePicker',
                ),
                initialTime: TimeOfDay(hour: 8, minute: 0),
                // initialValue: DateTime.now(),
                enabled: false,
              ),
              FormBuilderDateRangePicker(
                name: 'date_range',
                firstDate: DateTime(1970),
                lastDate: DateTime(2030),
                format: DateFormat('yyyy-MM-dd'),
                onChanged: _onChanged,
                decoration: InputDecoration(
                  labelText: 'DateRangePicker',
                  helperText: 'Helper text',
                  hintText: 'Hint text',
                ),
              ),
              FormBuilderSlider(
                name: 'slider',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.min(context, 6),
                ]),
                onChanged: _onChanged,
                min: 0.0,
                max: 10.0,
                initialValue: 7.0,
                divisions: 20,
                activeColor: Colors.red,
                inactiveColor: Colors.pink[100],
                decoration: InputDecoration(
                  labelText: 'Slider',
                ),
              ),
              FormBuilderRangeSlider(
                name: 'range_slider',
                decoration: InputDecoration(
                  labelText: 'RangeSlider',
                ),
                min: 0.0,
                max: 10.0,
                divisions: 10,
                initialValue: RangeValues(2.5, 7.5),
              ),
              FormBuilderTextField(
                name: 'age',
                decoration: InputDecoration(
                  labelText:
                      'Value is passed to the [Text.maxLines] attribute of the [Text] widget used to display the hint text.',
                ),
                onChanged: _onChanged,
                valueTransformer: (text) => num.tryParse(text!),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.numeric(context),
                  FormBuilderValidators.max(context, 70),
                ]),
                keyboardType: TextInputType.number,
              ),
              FormBuilderDropdown(
                name: 'gender',
                decoration: InputDecoration(
                  labelText: 'Dropdown',
                ),
                initialValue: 'male',
                allowClear: true,
                hint: Text('Select Gender'),
                items: genderOptions
                    .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text('$gender'),
                        ))
                    .toList(),
              ),
              FormBuilderField(
                name: 'customField',
                builder: (FormFieldState<dynamic> field) {
                  return InputDecorator(
                    decoration: InputDecoration(
                        labelText: "Custom Field",
                        border: InputBorder.none,
                        errorText: field.errorText),
                    child: Container(
                      height: 75,
                      child: CupertinoPicker(
                        itemExtent: 30,
                        // return a map of options from a list
                        children: options.map((c) => Text(c)).toList(),
                        onSelectedItemChanged: (index) {
                          // check when the field changes
                          field.didChange(options[index]);
                        },
                      ),
                    ),
                  );
                },
                // custom validator
                validator: (value) {
                  if (value != 'Option 3') {
                    return 'Answer is different from Option 3';
                  }
                  return null;
                },
              )
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: MaterialButton(
                color: Theme.of(context).colorScheme.secondary,
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  // form has to be saved before reading the data
                  _formKey.currentState!.save();
                  // to save specific fields
                  //   _formKey.currentState!.fields['gender']!.save();
                  if (_formKey.currentState!.validate()) {
                    // for all the values of the form in a map
                    print(_formKey.currentState!.value);
                    // for a specific value
                    print(_formKey.currentState!.fields['gender']!.value);
                  } else {
                    print("validation failed");
                  }
                },
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: MaterialButton(
                color: Theme.of(context).colorScheme.secondary,
                child: Text(
                  "Reset",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _formKey.currentState!.reset();

                  // Optional: unfocus keyboard
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  void _onChanged(dynamic value) {
    print(value);
  }
}
