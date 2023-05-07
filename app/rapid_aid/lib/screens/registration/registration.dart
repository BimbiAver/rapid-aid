import 'package:flutter/material.dart';
import 'package:rapid_aid/controllers/user_auth_controller.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

enum ExtraTopping { yes, no }

class _RegistrationState extends State<Registration> {
  String _gender = '';
  String? _bloodGroup;
  String? _relationship;

  final _registrationFormKey = GlobalKey<FormState>();

  final _nicNoFormController = TextEditingController();
  final _firstNameFormController = TextEditingController();
  final _lastNameFormController = TextEditingController();
  final _dobFormController = TextEditingController();
  final _addressFormController = TextEditingController();
  final _mobileNoFormController = TextEditingController();
  final _emailAddressFormController = TextEditingController();
  final _guardianNicNoFormController = TextEditingController();
  final _guardianFullNameFormController = TextEditingController();
  final _guardianAddressFormController = TextEditingController();
  final _guardianContactNoFormController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _nicNoFormController.dispose();
    _firstNameFormController.dispose();
    _lastNameFormController.dispose();
    _dobFormController.dispose();
    _addressFormController.dispose();
    _mobileNoFormController.dispose();
    _emailAddressFormController.dispose();
    _guardianNicNoFormController.dispose();
    _guardianFullNameFormController.dispose();
    _guardianAddressFormController.dispose();
    _guardianContactNoFormController.dispose();
    super.dispose();
  }

  Future<void> _selectDob(BuildContext context) async {
    final DateTime? dobPicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1960, 1),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF03045E), // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Color(0xFF03045E), // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFE01E37), // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (dobPicked != null) {
      setState(() {
        _dobFormController.text = dobPicked.toLocal().toString().split(' ')[0];
      });
    }
  }

  final ScrollController _scrollController = ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE01E37),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus
              ?.unfocus(), // Hide the soft keyboard
          child: Column(
            children: [
              Image.asset('assets/images/wave_red.png'),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Form(
                  key: _registrationFormKey,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/logo_transparent.png',
                        width: 220,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'Create Your Account',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "A few clicks away from creating your account. Please enter the info to proceed. We won't share your details with anyone.",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          height: 1.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 350,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade600),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 3, vertical: 10),
                        child: Scrollbar(
                          thumbVisibility: true, //always show scrollbar
                          thickness: 3, //width of scrollbar
                          scrollbarOrientation: ScrollbarOrientation.right,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 12),
                            child: Column(
                              children: [
                                TextFormField(
                                  maxLines: 1,
                                  maxLength: 12,
                                  controller: _nicNoFormController,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF03045E),
                                        width: 2,
                                      ),
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: 'NIC Number',
                                    hintText: "XXXXXXXXXX",
                                    counterText: '',
                                    prefixIcon: Icon(Icons.pin),
                                    prefixIconColor: Colors.black,
                                    labelStyle: TextStyle(color: Colors.black),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "* Required";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  maxLines: 1,
                                  controller: _firstNameFormController,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF03045E),
                                        width: 2,
                                      ),
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: 'First Name',
                                    hintText: "Deshan",
                                    prefixIcon: Icon(Icons.person),
                                    prefixIconColor: Colors.black,
                                    labelStyle: TextStyle(color: Colors.black),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "* Required";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  maxLines: 1,
                                  controller: _lastNameFormController,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF03045E),
                                        width: 2,
                                      ),
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: 'Last Name',
                                    hintText: "Abeykoon",
                                    prefixIcon: Icon(Icons.person),
                                    prefixIconColor: Colors.black,
                                    labelStyle: TextStyle(color: Colors.black),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "* Required";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(Icons.group),
                                    Expanded(
                                      child: RadioListTile(
                                          title: const Text('Male'),
                                          value: 'Male',
                                          groupValue: _gender,
                                          activeColor: const Color(0xFF03045E),
                                          onChanged: (value) {
                                            setState(() {
                                              _gender = value!;
                                            });
                                          }),
                                    ),
                                    Expanded(
                                      child: RadioListTile(
                                          title: const Text('Female'),
                                          value: 'Female',
                                          groupValue: _gender,
                                          activeColor: const Color(0xFF03045E),
                                          onChanged: (value) {
                                            setState(() {
                                              _gender = value!;
                                            });
                                          }),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  maxLines: 1,
                                  controller: _dobFormController,
                                  readOnly: true,
                                  onTap: () {
                                    _selectDob(context);
                                  },
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF03045E),
                                        width: 2,
                                      ),
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: 'Date of Birth',
                                    hintText: "1999-01-01",
                                    prefixIcon: Icon(Icons.date_range),
                                    prefixIconColor: Colors.black,
                                    labelStyle: TextStyle(color: Colors.black),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "* Required";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  maxLines: 1,
                                  maxLength: 50,
                                  controller: _addressFormController,
                                  keyboardType: TextInputType.streetAddress,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF03045E),
                                        width: 2,
                                      ),
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: 'Address',
                                    hintText: "No. 12/A, Silva St, Colombo",
                                    counterText: '',
                                    prefixIcon: Icon(Icons.place),
                                    prefixIconColor: Colors.black,
                                    labelStyle: TextStyle(color: Colors.black),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "* Required";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  maxLines: 1,
                                  maxLength: 9,
                                  controller: _mobileNoFormController,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF03045E),
                                        width: 2,
                                      ),
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: 'Mobile Number',
                                    hintText: "77XXXXXXXX",
                                    counterText: '',
                                    prefixIcon: Icon(Icons.phone_iphone),
                                    prefixIconColor: Colors.black,
                                    labelStyle: TextStyle(color: Colors.black),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "* Required";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  maxLines: 1,
                                  maxLength: 25,
                                  controller: _emailAddressFormController,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF03045E),
                                        width: 2,
                                      ),
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: 'Email Address',
                                    hintText: "email@example.com",
                                    counterText: '',
                                    prefixIcon: Icon(Icons.email),
                                    prefixIconColor: Colors.black,
                                    labelStyle: TextStyle(color: Colors.black),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "* Required";
                                    } else if (!RegExp(
                                            r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                      return "* Enter a valid email";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                InputDecorator(
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.bloodtype),
                                    prefixIconColor: Colors.black,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField(
                                      value: _bloodGroup,
                                      isDense: true,
                                      isExpanded: true,
                                      hint: const Text('Blood Group'),
                                      decoration:
                                          const InputDecoration.collapsed(
                                              hintText: ''),
                                      validator: (value) {
                                        if (value == null) {
                                          return "* Required";
                                        } else {
                                          return null;
                                        }
                                      },
                                      items: [
                                        'A+',
                                        'A-',
                                        'B+',
                                        'B-',
                                        'AB+',
                                        'AB-',
                                        'O+',
                                        'O-'
                                      ].map<DropdownMenuItem<String>>(
                                          (String blood) {
                                        return DropdownMenuItem<String>(
                                          value: blood,
                                          child: Text(
                                            blood,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? blood) {
                                        setState(() {
                                          _bloodGroup = blood ?? '';
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Divider(
                                  color: Colors.grey.shade700,
                                  thickness: 0.8,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  maxLines: 1,
                                  maxLength: 12,
                                  controller: _guardianNicNoFormController,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF03045E),
                                        width: 2,
                                      ),
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: "Guardian's NIC Number",
                                    hintText: "XXXXXXXXXX",
                                    counterText: '',
                                    prefixIcon: Icon(Icons.pin),
                                    prefixIconColor: Colors.black,
                                    labelStyle: TextStyle(color: Colors.black),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "* Required";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  maxLines: 1,
                                  controller: _guardianFullNameFormController,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF03045E),
                                        width: 2,
                                      ),
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: "Guardian's Full Name",
                                    hintText: "Deshan",
                                    prefixIcon: Icon(Icons.person),
                                    prefixIconColor: Colors.black,
                                    labelStyle: TextStyle(color: Colors.black),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "* Required";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  maxLines: 1,
                                  maxLength: 50,
                                  controller: _guardianAddressFormController,
                                  keyboardType: TextInputType.streetAddress,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF03045E),
                                        width: 2,
                                      ),
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: "Guardian's Address",
                                    hintText: "No. 12/A, Silva St, Colombo",
                                    counterText: '',
                                    prefixIcon: Icon(Icons.place),
                                    prefixIconColor: Colors.black,
                                    labelStyle: TextStyle(color: Colors.black),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "* Required";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  maxLines: 1,
                                  maxLength: 9,
                                  controller: _guardianContactNoFormController,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF03045E),
                                        width: 2,
                                      ),
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: "Guardian's Contact Number",
                                    hintText: "7XXXXXXXX",
                                    counterText: '',
                                    prefixIcon: Icon(Icons.phone_iphone),
                                    prefixIconColor: Colors.black,
                                    labelStyle: TextStyle(color: Colors.black),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "* Required";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                InputDecorator(
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.people),
                                    prefixIconColor: Colors.black,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField(
                                      value: _relationship,
                                      isDense: true,
                                      isExpanded: true,
                                      hint: const Text('Relationship'),
                                      decoration:
                                          const InputDecoration.collapsed(
                                              hintText: ''),
                                      validator: (value) {
                                        if (value == null) {
                                          return "* Required";
                                        } else {
                                          return null;
                                        }
                                      },
                                      items: [
                                        'Child',
                                        'Friend',
                                        'Parent',
                                        'Partner',
                                        'Sibling',
                                        'Spouse',
                                        'Other',
                                      ].map<DropdownMenuItem<String>>(
                                          (String relatioship) {
                                        return DropdownMenuItem<String>(
                                          value: relatioship,
                                          child: Text(
                                            relatioship,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? relatioship) {
                                        setState(() {
                                          _relationship = relatioship ?? '';
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 130,
                        child: ElevatedButton(
                          // Navigate to the login screen
                          onPressed: () async {
                            if (_registrationFormKey.currentState!.validate()) {
                              await UserAuthController().register(
                                context: context,
                                nicNo: _nicNoFormController.text,
                                firstName: _firstNameFormController.text,
                                lastName: _lastNameFormController.text,
                                gender: _gender,
                                dob: _dobFormController.text,
                                address: _addressFormController.text,
                                mobileNo: _mobileNoFormController.text,
                                emailAddress: _emailAddressFormController.text,
                                bloodGroup: _bloodGroup,
                                guardianNicNo:
                                    _guardianNicNoFormController.text,
                                guardianFullName:
                                    _guardianFullNameFormController.text,
                                guardianAddress:
                                    _guardianAddressFormController.text,
                                guardianContactNo:
                                    _guardianContactNoFormController.text,
                                relationship: _relationship,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE01E37),
                          ),
                          child: const Text('Register'),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
