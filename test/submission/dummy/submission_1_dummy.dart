import 'package:app_riverpod/core/state/base_state.dart';
import 'package:app_riverpod/data/district/district.dart';
import 'package:app_riverpod/data/province/province.dart';
import 'package:app_riverpod/module/submission/common/district/state/district_data.dart';
import 'package:app_riverpod/module/submission/common/district/state/district_state.dart';

import 'package:app_riverpod/module/submission/common/province/state/province_data.dart';
import 'package:app_riverpod/module/submission/common/province/state/province_state.dart';

// Test data constants
const String customerIdTest = 'customer-123';

// Dummy models
const Province dummyProvince = Province(
  id: 1,
  name: 'DKI Jakarta',
);

const District dummyDistrict = District(
  id: 101,
  name: 'Jakarta Pusat',
  provinceId: 1,
);

// Dummy states
const ProvinceState dummyProvinceState = ProvinceState(
  data: ProvinceData(
    province: [dummyProvince],
    selectedProvince: dummyProvince,
  ),
  stateStatus: StateStatus.success,
);

const DistrictState dummyDistrictState = DistrictState(
  data: DistrictData(
    district: [dummyDistrict],
    selectedDistrict: dummyDistrict,
  ),
  stateStatus: StateStatus.success,
);
