// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import '../../../../helpers/assets_provider.dart';
// import '../../../../helpers/constants.dart';
// import 'package:user_repository/user_repository.dart';

// import '../../../../blocs.dart';
// import '../../../../helpers/helpers.dart';

// class UserForm extends StatelessWidget {
//   const UserForm({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text('Nombre(s) *',
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyMedium!
//                 .copyWith(fontWeight: FontWeight.w500)),
//         const SizedBox(height: 16),
//         const SizedBox(height: 16),
//         Text('Apellido(s) *',
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyMedium!
//                 .copyWith(fontWeight: FontWeight.w500)),
//         const SizedBox(height: 16),
//         const SizedBox(height: 16),
//         Text('Fecha de nacimiento',
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyMedium!
//                 .copyWith(fontWeight: FontWeight.w500)),
//         const SizedBox(height: 16),
//         const _DatePicker(),
//         const SizedBox(height: 16),
//         Text('Peso',
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyMedium!
//                 .copyWith(fontWeight: FontWeight.w500)),
//         const SizedBox(height: 16),
//         const _WeightField(),
//         const SizedBox(height: 16),
//         Text('Altura',
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyMedium!
//                 .copyWith(fontWeight: FontWeight.w500)),
//         const SizedBox(height: 16),
//         const _HeightField(),
//         const SizedBox(height: 16),
//         Text('Sexo',
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyMedium!
//                 .copyWith(fontWeight: FontWeight.w500)),
//         const SizedBox(height: 16),
//         const _SexDropDown(),
//         const SizedBox(height: 16),
//       ],
//     );
//   }
// }

// class _SexDropDown extends StatelessWidget {
//   const _SexDropDown({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<UserFormCubit, UserFormState>(
//       builder: (context, state) {
//         return Container(
//           height: 60,
//           padding: defaultPadding,
//           decoration: BoxDecoration(
//             color: Theme.of(context).colorScheme.secondary,
//             borderRadius: BorderRadius.circular(10),
//             border: state.enabled
//                 ? null
//                 : Border.all(color: Theme.of(context).colorScheme.onSecondary),
//           ),
//           width: MediaQuery.of(context).size.width,
//           child: DropdownButtonHideUnderline(
//               child: DropdownButton<Sex>(
//             borderRadius: BorderRadius.circular(10),
//             elevation: 0,
//             hint: const Text('Seleccione un sexo'),
//             value: state.sex,
//             style: Theme.of(context).textTheme.bodyMedium,
//             dropdownColor: Theme.of(context).colorScheme.secondary,
//             icon: Transform.rotate(
//                 angle: 11, child: const Icon(Icons.chevron_left)),
//             items: const <DropdownMenuItem<Sex>>[
//               DropdownMenuItem<Sex>(
//                 child: Text(
//                   'Femenino',
//                 ),
//                 value: Sex.femenino,
//               ),
//               DropdownMenuItem<Sex>(
//                 child: Text(
//                   'Masculino',
//                 ),
//                 value: Sex.masculino,
//               ),
//               DropdownMenuItem<Sex>(
//                 child: Text(
//                   'Otro',
//                 ),
//                 value: Sex.otro,
//               ),
//             ],
//             onChanged: !state.enabled
//                 ? null
//                 : (Sex? value) {
//                     context.read<UserFormCubit>().sexChanged(value);
//                   },
//           )),
//         );
//       },
//     );
//   }
// }

// class _DatePicker extends StatelessWidget {
//   const _DatePicker({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () async {
//         if (!context.read<UserFormCubit>().state.enabled) return;
//         HapticFeedback.lightImpact();

//         var _dateTime = await showDatePicker(
//           context: context,
//           initialEntryMode: DatePickerEntryMode.calendarOnly,
//           initialDatePickerMode: DatePickerMode.year,
//           initialDate: DateTime.now(),
//           firstDate: DateTime(1900),
//           lastDate: DateTime.now(),
//         );

//         if (_dateTime != null) {
//           context.read<UserFormCubit>().birthDateChanged(_dateTime);
//         }
//       },
//       child: BlocBuilder<UserFormCubit, UserFormState>(
//         builder: (context, state) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).colorScheme.secondary,
//                   borderRadius: BorderRadius.circular(10),
//                   border: state.enabled
//                       ? null
//                       : Border.all(
//                           color:
//                               Theme.of(context).colorScheme.secondaryContainer),
//                 ),
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 300),
//                   height: 60,
//                   padding: defaultPadding,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     border:
//                         state.birthDate.valid || state.birthDate.value == null
//                             ? null
//                             : Border.all(
//                                 color: Theme.of(context).colorScheme.error),
//                     color: Theme.of(context).colorScheme.secondary,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Row(
//                     children: [
//                       Text(
//                         state.birthDate.value == null
//                             ? 'Selecciona una fecha'
//                             : formatDate(state.birthDate.value!),
//                         style: state.birthDate.value == null
//                             ? Theme.of(context).textTheme.bodyMedium!.copyWith(
//                                 color: Theme.of(context)
//                                     .textTheme
//                                     .bodyMedium!
//                                     .color!
//                                     .withOpacity(0.5))
//                             : Theme.of(context).textTheme.bodyMedium,
//                       ),
//                       const Spacer(),
//                       SizedBox(
//                           height: 20,
//                           width: 20,
//                           child: SvgPicture.asset(AssetsProvider.calendarIcon))
//                     ],
//                   ),
//                 ),
//               ),
//               state.birthDate.valid || state.birthDate.value == null
//                   ? Container()
//                   : Padding(
//                       padding: const EdgeInsets.only(top: 8),
//                       child: Text('   La edad debe ser mayor a 18 años.',
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyMedium!
//                               .copyWith(
//                                   color: Theme.of(context).colorScheme.error)),
//                     ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// class _WeightField extends StatelessWidget {
//   const _WeightField({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<UserFormCubit, UserFormState>(
//       builder: (context, state) {
//         bool showErrorText = state.weight.value == 0.0 && state.weight.invalid;

//         return TextFormField(
//             enabled: state.enabled,
//             key: const Key('user_weight'),
//             textInputAction: TextInputAction.next,
//             controller: context.read<UserFormCubit>().weightController,
//             onChanged: (String? value) {
//               if (value!.isEmpty) {
//                 return context.read<UserFormCubit>().weightChanged(-1);
//               }

//               if (value.contains(',')) {
//                 value = value.replaceAll(',', '.');
//               }

//               double? weight = double.tryParse(value);
//               weight ??= 0;

//               context.read<UserFormCubit>().weightChanged(weight);
//             },
//             keyboardType: const TextInputType.numberWithOptions(decimal: true),
//             style: Theme.of(context).textTheme.bodyMedium,
//             decoration: InputDecoration(
//                 hintText: 'Ej: 80',
//                 hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                       color: Theme.of(context)
//                           .colorScheme
//                           .onSurface
//                           .withOpacity(0.6),
//                     ),
//                 filled: true,
//                 fillColor: Theme.of(context).colorScheme.secondary,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 disabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide(
//                     color: Theme.of(context).colorScheme.secondaryContainer,
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide(
//                       color: Theme.of(context).colorScheme.secondary),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide(
//                       color: Theme.of(context).colorScheme.secondary),
//                 ),
//                 errorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide:
//                       BorderSide(color: Theme.of(context).colorScheme.error),
//                 ),
//                 focusedErrorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide:
//                       BorderSide(color: Theme.of(context).colorScheme.error),
//                 ),
//                 errorText: !showErrorText ? null : 'El peso es inválido.',
//                 errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                       color: Theme.of(context).colorScheme.error,
//                     ),
//                 labelStyle: state.errorMessage == null
//                     ? Theme.of(context).textTheme.bodyMedium
//                     : Theme.of(context).textTheme.bodyMedium,
//                 floatingLabelStyle: state.errorMessage == null
//                     ? Theme.of(context).textTheme.bodyMedium
//                     : Theme.of(context).textTheme.bodyMedium,
//                 suffixIcon: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'kg',
//                         style: Theme.of(context)
//                             .textTheme
//                             .bodyMedium!
//                             .copyWith(fontWeight: FontWeight.w500),
//                       ),
//                       if (state.weight.valid)
//                         SizedBox(
//                           height: 30,
//                           width: 30,
//                           child: state.enabled
//                               ? showCheckIcon(state.weight.valid, context)
//                               : Container(),
//                         )
//                     ]),
//                 suffixIconConstraints: const BoxConstraints(
//                     maxHeight: 30, maxWidth: 60, minHeight: 30, minWidth: 60)));
//       },
//     );
//   }
// }

// class _HeightField extends StatelessWidget {
//   const _HeightField({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<UserFormCubit, UserFormState>(
//       builder: (context, state) {
//         bool showErrorText = state.height.value == 0.0 && state.height.invalid;

//         return TextFormField(
//             enabled: state.enabled,
//             key: const Key('user_height'),
//             textInputAction: TextInputAction.next,
//             onChanged: (String? value) {
//               if (value!.isEmpty) {
//                 return context.read<UserFormCubit>().heightChanged(-1);
//               }

//               int? height = int.tryParse(value);

//               height ??= 0;

//               context.read<UserFormCubit>().heightChanged(height);
//             },
//             controller: context.read<UserFormCubit>().heightController,
//             keyboardType: TextInputType.number,
//             inputFormatters: const [],
//             style: Theme.of(context).textTheme.bodyMedium,
//             decoration: InputDecoration(
//               hintText: 'Ej: 175',
//               hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                     color: Theme.of(context)
//                         .colorScheme
//                         .onSurface
//                         .withOpacity(0.6),
//                   ),
//               filled: true,
//               fillColor: Theme.of(context).colorScheme.secondary,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               disabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide(
//                   color: Theme.of(context).colorScheme.secondaryContainer,
//                 ),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide:
//                     BorderSide(color: Theme.of(context).colorScheme.secondary),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide:
//                     BorderSide(color: Theme.of(context).colorScheme.secondary),
//               ),
//               errorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide:
//                     BorderSide(color: Theme.of(context).colorScheme.error),
//               ),
//               focusedErrorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide:
//                     BorderSide(color: Theme.of(context).colorScheme.error),
//               ),
//               errorText: !showErrorText ? null : 'La altura es inválida.',
//               errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                     color: Theme.of(context).colorScheme.error,
//                   ),
//               labelStyle: state.errorMessage == null
//                   ? Theme.of(context).textTheme.bodyMedium
//                   : Theme.of(context).textTheme.bodyMedium,
//               floatingLabelStyle: state.errorMessage == null
//                   ? Theme.of(context).textTheme.bodyMedium
//                   : Theme.of(context).textTheme.bodyMedium,
//               suffixIcon: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'cm',
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyMedium!
//                           .copyWith(fontWeight: FontWeight.w500),
//                     ),
//                     SizedBox(
//                       height: 30,
//                       width: 30,
//                       child: state.enabled
//                           ? showCheckIcon(state.height.valid, context)
//                           : Container(),
//                     )
//                   ]),
//               suffixIconConstraints: const BoxConstraints(
//                   maxHeight: 30, maxWidth: 60, minHeight: 30, minWidth: 60),
//             ));
//       },
//     );
//   }
// }
