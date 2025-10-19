import 'package:eitherx/eitherx.dart';

typedef Failure=String;
typedef Success=void;
typedef Result=Future<Either<Failure,Success>>;