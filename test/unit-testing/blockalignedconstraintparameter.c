// TODO DEBUGGING
#define DWG_TYPE DWG_TYPE_BLOCKALIGNEDCONSTRAINTPARAMETER
#include "common.c"

void
api_process (dwg_object *obj)
{
  int error, isnew;
  BLOCKCONSTRAINTPARAMETER_fields;
  BLOCKPARAMVALUESET_fields;
  BITCODE_BL i;

  Dwg_Version_Type dwg_version = obj->parent->header.version;
#ifdef DEBUG_CLASSES
  dwg_obj_blockalignedconstraintparameter *_obj = dwg_object_to_BLOCKALIGNEDCONSTRAINTPARAMETER (obj);

  CHK_EVALEXPR (BLOCKALIGNEDCONSTRAINTPARAMETER);
  // AcDbBlockElement
  CHK_ENTITY_UTF8TEXT (_obj, BLOCKALIGNEDCONSTRAINTPARAMETER, name);
  CHK_ENTITY_TYPE (_obj, BLOCKALIGNEDCONSTRAINTPARAMETER, be_major, BL);
  CHK_ENTITY_TYPE (_obj, BLOCKALIGNEDCONSTRAINTPARAMETER, be_minor, BL);
  CHK_ENTITY_TYPE (_obj, BLOCKALIGNEDCONSTRAINTPARAMETER, eed1071, BL);
  // AcDbBlockParameter
  CHK_ENTITY_TYPE (_obj, BLOCKALIGNEDCONSTRAINTPARAMETER, show_properties, B);
  CHK_ENTITY_TYPE (_obj, BLOCKALIGNEDCONSTRAINTPARAMETER, chain_actions, B);
  // AcDbBlock2PtParameter
  CHK_ENTITY_3RD (_obj, BLOCKALIGNEDCONSTRAINTPARAMETER, def_basept);
  CHK_ENTITY_3RD (_obj, BLOCKALIGNEDCONSTRAINTPARAMETER, def_endpt);
  BLOCKPARAMETER_PropInfo (prop1)
  BLOCKPARAMETER_PropInfo (prop2)
  BLOCKPARAMETER_PropInfo (prop3)
  BLOCKPARAMETER_PropInfo (prop4)
  CHK_ENTITY_VECTOR_TYPE (_obj, BLOCKALIGNEDCONSTRAINTPARAMETER, prop_states, 4, BL);
  CHK_ENTITY_TYPE (_obj, BLOCKALIGNEDCONSTRAINTPARAMETER, parameter_base_location, BS);
  CHK_ENTITY_3RD (_obj, BLOCKALIGNEDCONSTRAINTPARAMETER, upd_basept);
  CHK_ENTITY_3RD (_obj, BLOCKALIGNEDCONSTRAINTPARAMETER, basept);
  CHK_ENTITY_3RD (_obj, BLOCKALIGNEDCONSTRAINTPARAMETER, upd_endpt);
  CHK_ENTITY_3RD (_obj, BLOCKALIGNEDCONSTRAINTPARAMETER, endpt);
  // AcDbBlockConstraintParameter
  CHK_ENTITY_H (_obj, BLOCKALIGNEDCONSTRAINTPARAMETER, dependency);
#endif
}
