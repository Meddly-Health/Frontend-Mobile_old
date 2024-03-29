import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meddly/calendar/view/widgets/supervised_container.dart';
import 'package:meddly/helpers/assets_provider.dart';
import 'package:meddly/routes/router.dart';
import '../../helpers/constants.dart';
import '../../widgets/widgets.dart';

import '../../blocs.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: defaultPadding,
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state.status != UserStatus.success) {
            return const Center(child: Loading());
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(AssetsProvider.bell),
              const SizedBox(height: 16),
              const _NameAndAvatar(),
              const SizedBox(height: 16),
              const _Line(),
              const SizedBox(height: 16),
              const _SupervisedText(),
              const SizedBox(height: 16),
              if (state.currentUser != null &&
                  state.supervising != null &&
                  state.supervising!.isNotEmpty)
                Column(
                  children: [
                    SupervisedContainer(
                      supervised: state.supervising!,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              DatePicker(
                DateTime.now(),
                height: 90,
                locale: 'es_SP',
                daysCount: 365,
                initialSelectedDate: DateTime.now(),
                selectionColor: Theme.of(context).colorScheme.primary,
                selectedTextColor: Colors.white,
                dateTextStyle: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
                dayTextStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.w500),
                monthTextStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.w500),
                onDateChange: (date) {
                  // New date selected
                },
              ),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}

class _SupervisedText extends StatelessWidget {
  const _SupervisedText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(
                  text: state.supervising != null && state.supervising!.isEmpty
                      ? 'No estas supervisando a nadie. '
                      : 'Estas supervisando a alguien. ',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .color!
                          .withOpacity(0.5))),
              TextSpan(
                  text: 'Cambiar',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      AutoRouter.of(context)
                          .push(const SelectSupervisedRoute());
                    },
                  style: Theme.of(context).textTheme.bodyMedium!)
            ],
          ),
        );
      },
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      height: 5,
      width: MediaQuery.of(context).size.width / 2,
    );
  }
}

class _NameAndAvatar extends StatelessWidget {
  const _NameAndAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: AutoSizeText(
                state.currentUser?.firstName != null
                    ? 'Buenos días, ${state.currentUser?.firstName}'
                    : 'Buenos días',
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 2,
                maxFontSize: Theme.of(context).textTheme.titleLarge!.fontSize!,
              ),
            ),
            const Spacer(flex: 1),
            const Avatar()
          ],
        );
      },
    );
  }
}
