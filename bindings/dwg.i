/*****************************************************************************/
/*  LibreDWG - free implementation of the DWG file format                    */
/*                                                                           */
/*  Copyright (C) 2010-2019 Free Software Foundation, Inc.                   */
/*                                                                           */
/*  This library is free software, licensed under the terms of the GNU       */
/*  General Public License as published by the Free Software Foundation,     */
/*  either version 3 of the License, or (at your option) any later version.  */
/*  You should have received a copy of the GNU General Public License        */
/*  along with this program.  If not, see <http://www.gnu.org/licenses/>.    */
/*****************************************************************************/

/*
 * dwg.i: SWIG interface file
 * written by Rodrigo Rodrigues da Silva
 * ideas contributed by James Michael DuPont
 * modified by Reini Urban
 */

%module LibreDWG

%{
#include "../src/config.h"
#include "dwg_api.h"
%}

%include "carrays.i"
%include "stdint.i"
%array_functions(Dwg_Object, Dwg_Object_Array);

// swig cpp parser error confusing an enum with a define
#pragma SWIG nowarn=305
%include "dwg.h"
//too large. TODO ifdef there
//%include "dwg_api.h"

/** dynapi */
typedef struct dwg_field_name_type_offset
{
  const char *const name;
  const char *const type;
  const unsigned short size;
  const unsigned short offset;
  const unsigned short is_indirect:1;
  const unsigned short is_malloc:1;
  const unsigned short is_string:1;
  const short dxf;
} Dwg_DYNAPI_field;

EXPORT bool is_dwg_entity (const char *name);
EXPORT bool is_dwg_object (const char *name);
EXPORT bool dwg_dynapi_header_value (const Dwg_Data *restrict dwg,
                                     const char *restrict fieldname,
                                     void *restrict out,
                                     Dwg_DYNAPI_field *restrict fp);
EXPORT bool dwg_dynapi_entity_value (void *restrict entity,
                                     const char *restrict dxfname,
                                     const char *restrict fieldname,
                                     void *restrict out,
                                     Dwg_DYNAPI_field *restrict fp);
EXPORT bool dwg_dynapi_common_value (void *restrict _obj,
                                     const char *restrict fieldname,
                                     void *restrict out,
                                     Dwg_DYNAPI_field *restrict fp);
EXPORT bool dwg_dynapi_subclass_value (const void *restrict ptr,
                                       const char *restrict subclass,
                                       const char *restrict fieldname,
                                       void *restrict out,
                                       Dwg_DYNAPI_field *restrict fp);
EXPORT bool dwg_dynapi_header_utf8text (const Dwg_Data *restrict dwg,
                                        const char *restrict fieldname,
                                        char **restrict textp, int *isnew,
                                        Dwg_DYNAPI_field *restrict fp);
EXPORT bool dwg_dynapi_entity_utf8text (void *restrict entity,
                                        const char *restrict name,
                                        const char *restrict fieldname,
                                        char **restrict textp, int *isnew,
                                        Dwg_DYNAPI_field *restrict fp);
EXPORT bool dwg_dynapi_common_utf8text (void *restrict _obj,
                                        const char *restrict fieldname,
                                        char **restrict textp, int *isnew,
                                        Dwg_DYNAPI_field *restrict fp);
EXPORT bool dwg_dynapi_header_set_value (const Dwg_Data *restrict dwg,
                                         const char *restrict fieldname,
                                         const void *restrict value,
                                         const bool is_utf8);
EXPORT bool dwg_dynapi_entity_set_value (void *restrict entity,
                                         const char *restrict dxfname,
                                         const char *restrict fieldname,
                                         const void *restrict value,
                                         const bool is_utf8);
EXPORT bool dwg_dynapi_common_set_value (void *restrict _obj,
                                         const char *restrict fieldname,
                                         const void *restrict value,
                                         const bool is_utf8);
EXPORT char *dwg_dynapi_handle_name (const Dwg_Data *restrict dwg,
                                     Dwg_Object_Ref *restrict hdl);
EXPORT const Dwg_DYNAPI_field *
dwg_dynapi_header_field (const char *restrict fieldname);
EXPORT const Dwg_DYNAPI_field *
dwg_dynapi_entity_field (const char *restrict name,
                         const char *restrict fieldname);
EXPORT const Dwg_DYNAPI_field *
dwg_dynapi_subclass_field (const char *restrict name,
                           const char *restrict fieldname);
EXPORT const Dwg_DYNAPI_field *
dwg_dynapi_common_entity_field (const char *restrict fieldname);
EXPORT const Dwg_DYNAPI_field *
dwg_dynapi_common_object_field (const char *restrict fieldname);
/* Find the fields for this entity or object. */
EXPORT const Dwg_DYNAPI_field *
dwg_dynapi_entity_fields (const char *restrict name);
EXPORT const Dwg_DYNAPI_field *dwg_dynapi_common_entity_fields (void);
EXPORT const Dwg_DYNAPI_field *dwg_dynapi_common_object_fields (void);
/* Find the fields for this subclass. See dwg.h */
EXPORT const Dwg_DYNAPI_field *
dwg_dynapi_subclass_fields (const char *restrict name);
/** The sum of the size of all fields, by entity or subclass name */
EXPORT int dwg_dynapi_fields_size (const char *restrict name);

EXPORT Dwg_Object_Ref **
dwg_object_tablectrl_get_entries(const Dwg_Object *restrict obj,
                                 int *restrict error);
EXPORT char *
dwg_ref_get_table_name(const Dwg_Object_Ref *restrict ref,
                       int *restrict error);
EXPORT char *
dwg_ent_get_layer_name(const dwg_obj_ent *restrict ent,
                       int *restrict error);
EXPORT char *
dwg_obj_layer_get_name(const dwg_obj_layer *restrict layer,
                          int *restrict error);
EXPORT char *
dwg_obj_table_get_name(const Dwg_Object *restrict obj,
                          int *restrict error);
EXPORT Dwg_Object *
dwg_ent_to_object(const dwg_obj_ent *restrict obj,
                          int *restrict error);
EXPORT Dwg_Object_Object *
dwg_object_to_object(Dwg_Object *restrict obj,
                     int *restrict error);
EXPORT Dwg_Object *
dwg_obj_obj_to_object(const Dwg_Object_Object *restrict obj,
                      int *restrict error);
EXPORT Dwg_Object_Entity *
dwg_object_to_entity(Dwg_Object *restrict obj,
                     int *restrict error);
EXPORT int
dwg_object_get_type(const Dwg_Object *obj);
EXPORT int
dwg_object_get_fixedtype(const Dwg_Object *obj);
EXPORT char*
dwg_object_get_dxfname(const Dwg_Object *obj);
EXPORT BITCODE_BL
dwg_ref_get_absref(const Dwg_Object_Ref *restrict ref,
                   int *restrict error);
EXPORT Dwg_Object *
dwg_ref_get_object(const Dwg_Object_Ref *restrict ref,
                   int *restrict error);
EXPORT Dwg_Object *
dwg_absref_get_object(const Dwg_Data* dwg, const BITCODE_BL absref);
EXPORT unsigned int
dwg_get_num_classes(const Dwg_Data *dwg);
EXPORT Dwg_Class *
dwg_get_class(const Dwg_Data *dwg, unsigned int index);
EXPORT Dwg_Object *
dwg_get_object(Dwg_Data *dwg, BITCODE_BL index);
EXPORT dwg_object *
dwg_obj_generic_to_object (const dwg_obj_generic *restrict obj,
                           int *restrict error);
EXPORT dwg_obj_obj *
dwg_obj_generic_parent (const dwg_obj_generic *restrict obj,
                        int *restrict error);

struct dwg_entity_DIMENSION_common *
dwg_object_to_DIMENSION(Dwg_Object *obj);

/* Start auto-generated content. Do not touch. */
/* dwg_getall_ API */
EXPORT Dwg_Entity_ARC** dwg_getall_ARC (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_ATTDEF** dwg_getall_ATTDEF (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_ATTRIB** dwg_getall_ATTRIB (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_BLOCK** dwg_getall_BLOCK (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_BODY** dwg_getall_BODY (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_CAMERA** dwg_getall_CAMERA (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_CIRCLE** dwg_getall_CIRCLE (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_DIMENSION_ALIGNED** dwg_getall_DIMENSION_ALIGNED (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_DIMENSION_ANG2LN** dwg_getall_DIMENSION_ANG2LN (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_DIMENSION_ANG3PT** dwg_getall_DIMENSION_ANG3PT (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_DIMENSION_DIAMETER** dwg_getall_DIMENSION_DIAMETER (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_DIMENSION_LINEAR** dwg_getall_DIMENSION_LINEAR (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_DIMENSION_ORDINATE** dwg_getall_DIMENSION_ORDINATE (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_DIMENSION_RADIUS** dwg_getall_DIMENSION_RADIUS (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_ELLIPSE** dwg_getall_ELLIPSE (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_ENDBLK** dwg_getall_ENDBLK (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_HATCH** dwg_getall_HATCH (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_IMAGE** dwg_getall_IMAGE (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_INSERT** dwg_getall_INSERT (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_LEADER** dwg_getall_LEADER (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_LIGHT** dwg_getall_LIGHT (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_LINE** dwg_getall_LINE (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_LWPOLYLINE** dwg_getall_LWPOLYLINE (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_MESH** dwg_getall_MESH (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_MINSERT** dwg_getall_MINSERT (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_MLINE** dwg_getall_MLINE (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_MTEXT** dwg_getall_MTEXT (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_MULTILEADER** dwg_getall_MULTILEADER (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_OLE2FRAME** dwg_getall_OLE2FRAME (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_OLEFRAME** dwg_getall_OLEFRAME (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_POINT** dwg_getall_POINT (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_POLYLINE_2D** dwg_getall_POLYLINE_2D (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_POLYLINE_3D** dwg_getall_POLYLINE_3D (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_POLYLINE_MESH** dwg_getall_POLYLINE_MESH (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_POLYLINE_PFACE** dwg_getall_POLYLINE_PFACE (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_PROXY_ENTITY** dwg_getall_PROXY_ENTITY (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_RAY** dwg_getall_RAY (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_REGION** dwg_getall_REGION (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_SECTIONOBJECT** dwg_getall_SECTIONOBJECT (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_SEQEND** dwg_getall_SEQEND (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_SHAPE** dwg_getall_SHAPE (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_SOLID** dwg_getall_SOLID (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_SPLINE** dwg_getall_SPLINE (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_TEXT** dwg_getall_TEXT (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_TOLERANCE** dwg_getall_TOLERANCE (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_TRACE** dwg_getall_TRACE (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_UNDERLAY** dwg_getall_UNDERLAY (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_UNKNOWN_ENT** dwg_getall_UNKNOWN_ENT (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_VERTEX_2D** dwg_getall_VERTEX_2D (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_VERTEX_3D** dwg_getall_VERTEX_3D (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_VERTEX_MESH** dwg_getall_VERTEX_MESH (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_VERTEX_PFACE** dwg_getall_VERTEX_PFACE (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_VERTEX_PFACE_FACE** dwg_getall_VERTEX_PFACE_FACE (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_VIEWPORT** dwg_getall_VIEWPORT (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_WIPEOUT** dwg_getall_WIPEOUT (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_XLINE** dwg_getall_XLINE (Dwg_Object_Ref* hdr);
/* unstable */
EXPORT Dwg_Entity_ARC_DIMENSION** dwg_getall_ARC_DIMENSION (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_HELIX** dwg_getall_HELIX (Dwg_Object_Ref* hdr);
EXPORT Dwg_Entity_LARGE_RADIAL_DIMENSION** dwg_getall_LARGE_RADIAL_DIMENSION (Dwg_Object_Ref* hdr);
#ifdef DEBUG_CLASSES
  EXPORT Dwg_Entity_ALIGNMENTPARAMETERENTITY** dwg_getall_ALIGNMENTPARAMETERENTITY (Dwg_Object_Ref* hdr);
  EXPORT Dwg_Entity_ATEXT** dwg_getall_ATEXT (Dwg_Object_Ref* hdr);
  EXPORT Dwg_Entity_BASEPOINTPARAMETERENTITY** dwg_getall_BASEPOINTPARAMETERENTITY (Dwg_Object_Ref* hdr);
  EXPORT Dwg_Entity_EXTRUDEDSURFACE** dwg_getall_EXTRUDEDSURFACE (Dwg_Object_Ref* hdr);
  EXPORT Dwg_Entity_FLIPPARAMETERENTITY** dwg_getall_FLIPPARAMETERENTITY (Dwg_Object_Ref* hdr);
  EXPORT Dwg_Entity_GEOPOSITIONMARKER** dwg_getall_GEOPOSITIONMARKER (Dwg_Object_Ref* hdr);
  EXPORT Dwg_Entity_LINEARPARAMETERENTITY** dwg_getall_LINEARPARAMETERENTITY (Dwg_Object_Ref* hdr);
  EXPORT Dwg_Entity_LOFTEDSURFACE** dwg_getall_LOFTEDSURFACE (Dwg_Object_Ref* hdr);
  EXPORT Dwg_Entity_MPOLYGON** dwg_getall_MPOLYGON (Dwg_Object_Ref* hdr);
  EXPORT Dwg_Entity_NAVISWORKSMODEL** dwg_getall_NAVISWORKSMODEL (Dwg_Object_Ref* hdr);
  EXPORT Dwg_Entity_NURBSURFACE** dwg_getall_NURBSURFACE (Dwg_Object_Ref* hdr);
  EXPORT Dwg_Entity_PLANESURFACE** dwg_getall_PLANESURFACE (Dwg_Object_Ref* hdr);
  EXPORT Dwg_Entity_POINTPARAMETERENTITY** dwg_getall_POINTPARAMETERENTITY (Dwg_Object_Ref* hdr);
  EXPORT Dwg_Entity_REVOLVEDSURFACE** dwg_getall_REVOLVEDSURFACE (Dwg_Object_Ref* hdr);
  EXPORT Dwg_Entity_ROTATIONPARAMETERENTITY** dwg_getall_ROTATIONPARAMETERENTITY (Dwg_Object_Ref* hdr);
  EXPORT Dwg_Entity_RTEXT** dwg_getall_RTEXT (Dwg_Object_Ref* hdr);
  EXPORT Dwg_Entity_SWEPTSURFACE** dwg_getall_SWEPTSURFACE (Dwg_Object_Ref* hdr);
  EXPORT Dwg_Entity_TABLE** dwg_getall_TABLE (Dwg_Object_Ref* hdr);
  EXPORT Dwg_Entity_VISIBILITYGRIPENTITY** dwg_getall_VISIBILITYGRIPENTITY (Dwg_Object_Ref* hdr);
  EXPORT Dwg_Entity_VISIBILITYPARAMETERENTITY** dwg_getall_VISIBILITYPARAMETERENTITY (Dwg_Object_Ref* hdr);
  EXPORT Dwg_Entity_XYPARAMETERENTITY** dwg_getall_XYPARAMETERENTITY (Dwg_Object_Ref* hdr);
#endif

EXPORT Dwg_Object_ACSH_BOOLEAN_CLASS** dwg_getall_ACSH_BOOLEAN_CLASS (Dwg_Data* dwg);
EXPORT Dwg_Object_ACSH_BOX_CLASS** dwg_getall_ACSH_BOX_CLASS (Dwg_Data* dwg);
EXPORT Dwg_Object_ACSH_CYLINDER_CLASS** dwg_getall_ACSH_CYLINDER_CLASS (Dwg_Data* dwg);
EXPORT Dwg_Object_ACSH_FILLET_CLASS** dwg_getall_ACSH_FILLET_CLASS (Dwg_Data* dwg);
EXPORT Dwg_Object_ACSH_SPHERE_CLASS** dwg_getall_ACSH_SPHERE_CLASS (Dwg_Data* dwg);
EXPORT Dwg_Object_ACSH_WEDGE_CLASS** dwg_getall_ACSH_WEDGE_CLASS (Dwg_Data* dwg);
EXPORT Dwg_Object_APPID** dwg_getall_APPID (Dwg_Data* dwg);
EXPORT Dwg_Object_APPID_CONTROL** dwg_getall_APPID_CONTROL (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCK_CONTROL** dwg_getall_BLOCK_CONTROL (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCK_HEADER** dwg_getall_BLOCK_HEADER (Dwg_Data* dwg);
EXPORT Dwg_Object_CELLSTYLEMAP** dwg_getall_CELLSTYLEMAP (Dwg_Data* dwg);
EXPORT Dwg_Object_DICTIONARY** dwg_getall_DICTIONARY (Dwg_Data* dwg);
EXPORT Dwg_Object_DICTIONARYVAR** dwg_getall_DICTIONARYVAR (Dwg_Data* dwg);
EXPORT Dwg_Object_DICTIONARYWDFLT** dwg_getall_DICTIONARYWDFLT (Dwg_Data* dwg);
EXPORT Dwg_Object_DIMSTYLE** dwg_getall_DIMSTYLE (Dwg_Data* dwg);
EXPORT Dwg_Object_DIMSTYLE_CONTROL** dwg_getall_DIMSTYLE_CONTROL (Dwg_Data* dwg);
EXPORT Dwg_Object_DUMMY** dwg_getall_DUMMY (Dwg_Data* dwg);
EXPORT Dwg_Object_DYNAMICBLOCKPURGEPREVENTER** dwg_getall_DYNAMICBLOCKPURGEPREVENTER (Dwg_Data* dwg);
EXPORT Dwg_Object_FIELD** dwg_getall_FIELD (Dwg_Data* dwg);
EXPORT Dwg_Object_FIELDLIST** dwg_getall_FIELDLIST (Dwg_Data* dwg);
EXPORT Dwg_Object_GEODATA** dwg_getall_GEODATA (Dwg_Data* dwg);
EXPORT Dwg_Object_GROUP** dwg_getall_GROUP (Dwg_Data* dwg);
EXPORT Dwg_Object_IDBUFFER** dwg_getall_IDBUFFER (Dwg_Data* dwg);
EXPORT Dwg_Object_IMAGEDEF** dwg_getall_IMAGEDEF (Dwg_Data* dwg);
EXPORT Dwg_Object_IMAGEDEF_REACTOR** dwg_getall_IMAGEDEF_REACTOR (Dwg_Data* dwg);
EXPORT Dwg_Object_INDEX** dwg_getall_INDEX (Dwg_Data* dwg);
EXPORT Dwg_Object_LAYER** dwg_getall_LAYER (Dwg_Data* dwg);
EXPORT Dwg_Object_LAYERFILTER** dwg_getall_LAYERFILTER (Dwg_Data* dwg);
EXPORT Dwg_Object_LAYER_CONTROL** dwg_getall_LAYER_CONTROL (Dwg_Data* dwg);
EXPORT Dwg_Object_LAYER_INDEX** dwg_getall_LAYER_INDEX (Dwg_Data* dwg);
EXPORT Dwg_Object_LAYOUT** dwg_getall_LAYOUT (Dwg_Data* dwg);
EXPORT Dwg_Object_LONG_TRANSACTION** dwg_getall_LONG_TRANSACTION (Dwg_Data* dwg);
EXPORT Dwg_Object_LTYPE** dwg_getall_LTYPE (Dwg_Data* dwg);
EXPORT Dwg_Object_LTYPE_CONTROL** dwg_getall_LTYPE_CONTROL (Dwg_Data* dwg);
EXPORT Dwg_Object_MLEADERSTYLE** dwg_getall_MLEADERSTYLE (Dwg_Data* dwg);
EXPORT Dwg_Object_MLINESTYLE** dwg_getall_MLINESTYLE (Dwg_Data* dwg);
EXPORT Dwg_Object_PLACEHOLDER** dwg_getall_PLACEHOLDER (Dwg_Data* dwg);
EXPORT Dwg_Object_PLOTSETTINGS** dwg_getall_PLOTSETTINGS (Dwg_Data* dwg);
EXPORT Dwg_Object_RASTERVARIABLES** dwg_getall_RASTERVARIABLES (Dwg_Data* dwg);
EXPORT Dwg_Object_SCALE** dwg_getall_SCALE (Dwg_Data* dwg);
EXPORT Dwg_Object_SECTION_MANAGER** dwg_getall_SECTION_MANAGER (Dwg_Data* dwg);
EXPORT Dwg_Object_SORTENTSTABLE** dwg_getall_SORTENTSTABLE (Dwg_Data* dwg);
EXPORT Dwg_Object_SPATIAL_FILTER** dwg_getall_SPATIAL_FILTER (Dwg_Data* dwg);
EXPORT Dwg_Object_STYLE** dwg_getall_STYLE (Dwg_Data* dwg);
EXPORT Dwg_Object_STYLE_CONTROL** dwg_getall_STYLE_CONTROL (Dwg_Data* dwg);
EXPORT Dwg_Object_TABLEGEOMETRY** dwg_getall_TABLEGEOMETRY (Dwg_Data* dwg);
EXPORT Dwg_Object_UCS** dwg_getall_UCS (Dwg_Data* dwg);
EXPORT Dwg_Object_UCS_CONTROL** dwg_getall_UCS_CONTROL (Dwg_Data* dwg);
EXPORT Dwg_Object_UNDERLAYDEFINITION** dwg_getall_UNDERLAYDEFINITION (Dwg_Data* dwg);
EXPORT Dwg_Object_UNKNOWN_OBJ** dwg_getall_UNKNOWN_OBJ (Dwg_Data* dwg);
EXPORT Dwg_Object_VBA_PROJECT** dwg_getall_VBA_PROJECT (Dwg_Data* dwg);
EXPORT Dwg_Object_VIEW** dwg_getall_VIEW (Dwg_Data* dwg);
EXPORT Dwg_Object_VIEW_CONTROL** dwg_getall_VIEW_CONTROL (Dwg_Data* dwg);
EXPORT Dwg_Object_VISUALSTYLE** dwg_getall_VISUALSTYLE (Dwg_Data* dwg);
EXPORT Dwg_Object_VPORT** dwg_getall_VPORT (Dwg_Data* dwg);
EXPORT Dwg_Object_VPORT_CONTROL** dwg_getall_VPORT_CONTROL (Dwg_Data* dwg);
EXPORT Dwg_Object_VPORT_ENTITY_CONTROL** dwg_getall_VPORT_ENTITY_CONTROL (Dwg_Data* dwg);
EXPORT Dwg_Object_VPORT_ENTITY_HEADER** dwg_getall_VPORT_ENTITY_HEADER (Dwg_Data* dwg);
EXPORT Dwg_Object_WIPEOUTVARIABLES** dwg_getall_WIPEOUTVARIABLES (Dwg_Data* dwg);
EXPORT Dwg_Object_XRECORD** dwg_getall_XRECORD (Dwg_Data* dwg);
/* unstable */
EXPORT Dwg_Object_ACSH_BREP_CLASS** dwg_getall_ACSH_BREP_CLASS (Dwg_Data* dwg);
EXPORT Dwg_Object_ACSH_CHAMFER_CLASS** dwg_getall_ACSH_CHAMFER_CLASS (Dwg_Data* dwg);
EXPORT Dwg_Object_ACSH_CONE_CLASS** dwg_getall_ACSH_CONE_CLASS (Dwg_Data* dwg);
EXPORT Dwg_Object_ACSH_PYRAMID_CLASS** dwg_getall_ACSH_PYRAMID_CLASS (Dwg_Data* dwg);
EXPORT Dwg_Object_ACSH_TORUS_CLASS** dwg_getall_ACSH_TORUS_CLASS (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCACTION** dwg_getall_ASSOCACTION (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCBLENDSURFACEACTIONBODY** dwg_getall_ASSOCBLENDSURFACEACTIONBODY (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCDEPENDENCY** dwg_getall_ASSOCDEPENDENCY (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCEXTENDSURFACEACTIONBODY** dwg_getall_ASSOCEXTENDSURFACEACTIONBODY (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCEXTRUDEDSURFACEACTIONBODY** dwg_getall_ASSOCEXTRUDEDSURFACEACTIONBODY (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCFILLETSURFACEACTIONBODY** dwg_getall_ASSOCFILLETSURFACEACTIONBODY (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCGEOMDEPENDENCY** dwg_getall_ASSOCGEOMDEPENDENCY (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCLOFTEDSURFACEACTIONBODY** dwg_getall_ASSOCLOFTEDSURFACEACTIONBODY (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCNETWORK** dwg_getall_ASSOCNETWORK (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCNETWORKSURFACEACTIONBODY** dwg_getall_ASSOCNETWORKSURFACEACTIONBODY (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCOFFSETSURFACEACTIONBODY** dwg_getall_ASSOCOFFSETSURFACEACTIONBODY (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCPATCHSURFACEACTIONBODY** dwg_getall_ASSOCPATCHSURFACEACTIONBODY (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCPLANESURFACEACTIONBODY** dwg_getall_ASSOCPLANESURFACEACTIONBODY (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCREVOLVEDSURFACEACTIONBODY** dwg_getall_ASSOCREVOLVEDSURFACEACTIONBODY (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCTRIMSURFACEACTIONBODY** dwg_getall_ASSOCTRIMSURFACEACTIONBODY (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCVALUEDEPENDENCY** dwg_getall_ASSOCVALUEDEPENDENCY (Dwg_Data* dwg);
EXPORT Dwg_Object_BACKGROUND** dwg_getall_BACKGROUND (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKGRIPLOCATIONCOMPONENT** dwg_getall_BLOCKGRIPLOCATIONCOMPONENT (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKVISIBILITYGRIP** dwg_getall_BLOCKVISIBILITYGRIP (Dwg_Data* dwg);
EXPORT Dwg_Object_DBCOLOR** dwg_getall_DBCOLOR (Dwg_Data* dwg);
EXPORT Dwg_Object_DETAILVIEWSTYLE** dwg_getall_DETAILVIEWSTYLE (Dwg_Data* dwg);
EXPORT Dwg_Object_DIMASSOC** dwg_getall_DIMASSOC (Dwg_Data* dwg);
EXPORT Dwg_Object_LIGHTLIST** dwg_getall_LIGHTLIST (Dwg_Data* dwg);
EXPORT Dwg_Object_MATERIAL** dwg_getall_MATERIAL (Dwg_Data* dwg);
EXPORT Dwg_Object_MENTALRAYRENDERSETTINGS** dwg_getall_MENTALRAYRENDERSETTINGS (Dwg_Data* dwg);
EXPORT Dwg_Object_OBJECT_PTR** dwg_getall_OBJECT_PTR (Dwg_Data* dwg);
EXPORT Dwg_Object_PROXY_OBJECT** dwg_getall_PROXY_OBJECT (Dwg_Data* dwg);
EXPORT Dwg_Object_RAPIDRTRENDERSETTINGS** dwg_getall_RAPIDRTRENDERSETTINGS (Dwg_Data* dwg);
EXPORT Dwg_Object_RENDERSETTINGS** dwg_getall_RENDERSETTINGS (Dwg_Data* dwg);
EXPORT Dwg_Object_SECTIONVIEWSTYLE** dwg_getall_SECTIONVIEWSTYLE (Dwg_Data* dwg);
EXPORT Dwg_Object_SECTION_SETTINGS** dwg_getall_SECTION_SETTINGS (Dwg_Data* dwg);
EXPORT Dwg_Object_SPATIAL_INDEX** dwg_getall_SPATIAL_INDEX (Dwg_Data* dwg);
EXPORT Dwg_Object_SUN** dwg_getall_SUN (Dwg_Data* dwg);
EXPORT Dwg_Object_TABLESTYLE** dwg_getall_TABLESTYLE (Dwg_Data* dwg);
#ifdef DEBUG_CLASSES
EXPORT Dwg_Object_ACMECOMMANDHISTORY** dwg_getall_ACMECOMMANDHISTORY (Dwg_Data* dwg);
EXPORT Dwg_Object_ACMESCOPE** dwg_getall_ACMESCOPE (Dwg_Data* dwg);
EXPORT Dwg_Object_ACMESTATEMGR** dwg_getall_ACMESTATEMGR (Dwg_Data* dwg);
EXPORT Dwg_Object_ACSH_EXTRUSION_CLASS** dwg_getall_ACSH_EXTRUSION_CLASS (Dwg_Data* dwg);
EXPORT Dwg_Object_ACSH_HISTORY_CLASS** dwg_getall_ACSH_HISTORY_CLASS (Dwg_Data* dwg);
EXPORT Dwg_Object_ACSH_LOFT_CLASS** dwg_getall_ACSH_LOFT_CLASS (Dwg_Data* dwg);
EXPORT Dwg_Object_ACSH_REVOLVE_CLASS** dwg_getall_ACSH_REVOLVE_CLASS (Dwg_Data* dwg);
EXPORT Dwg_Object_ACSH_SWEEP_CLASS** dwg_getall_ACSH_SWEEP_CLASS (Dwg_Data* dwg);
EXPORT Dwg_Object_ALDIMOBJECTCONTEXTDATA** dwg_getall_ALDIMOBJECTCONTEXTDATA (Dwg_Data* dwg);
EXPORT Dwg_Object_ANGDIMOBJECTCONTEXTDATA** dwg_getall_ANGDIMOBJECTCONTEXTDATA (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOC2DCONSTRAINTGROUP** dwg_getall_ASSOC2DCONSTRAINTGROUP (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOC3POINTANGULARDIMACTIONBODY** dwg_getall_ASSOC3POINTANGULARDIMACTIONBODY (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCACTIONPARAM** dwg_getall_ASSOCACTIONPARAM (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCALIGNEDDIMACTIONBODY** dwg_getall_ASSOCALIGNEDDIMACTIONBODY (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCARRAYACTIONBODY** dwg_getall_ASSOCARRAYACTIONBODY (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCARRAYMODIFYACTIONBODY** dwg_getall_ASSOCARRAYMODIFYACTIONBODY (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCARRAYMODIFYPARAMETERS** dwg_getall_ASSOCARRAYMODIFYPARAMETERS (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCARRAYPATHPARAMETERS** dwg_getall_ASSOCARRAYPATHPARAMETERS (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCARRAYPOLARPARAMETERS** dwg_getall_ASSOCARRAYPOLARPARAMETERS (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCARRAYRECTANGULARPARAMETERS** dwg_getall_ASSOCARRAYRECTANGULARPARAMETERS (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCASMBODYACTIONPARAM** dwg_getall_ASSOCASMBODYACTIONPARAM (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCCOMPOUNDACTIONPARAM** dwg_getall_ASSOCCOMPOUNDACTIONPARAM (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCDIMDEPENDENCYBODY** dwg_getall_ASSOCDIMDEPENDENCYBODY (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCEDGEACTIONPARAM** dwg_getall_ASSOCEDGEACTIONPARAM (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCEDGECHAMFERACTIONBODY** dwg_getall_ASSOCEDGECHAMFERACTIONBODY (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCEDGEFILLETACTIONBODY** dwg_getall_ASSOCEDGEFILLETACTIONBODY (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCFACEACTIONPARAM** dwg_getall_ASSOCFACEACTIONPARAM (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCMLEADERACTIONBODY** dwg_getall_ASSOCMLEADERACTIONBODY (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCOBJECTACTIONPARAM** dwg_getall_ASSOCOBJECTACTIONPARAM (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCORDINATEDIMACTIONBODY** dwg_getall_ASSOCORDINATEDIMACTIONBODY (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCOSNAPPOINTREFACTIONPARAM** dwg_getall_ASSOCOSNAPPOINTREFACTIONPARAM (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCPATHACTIONPARAM** dwg_getall_ASSOCPATHACTIONPARAM (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCPERSSUBENTMANAGER** dwg_getall_ASSOCPERSSUBENTMANAGER (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCPOINTREFACTIONPARAM** dwg_getall_ASSOCPOINTREFACTIONPARAM (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCRESTOREENTITYSTATEACTIONBODY** dwg_getall_ASSOCRESTOREENTITYSTATEACTIONBODY (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCROTATEDDIMACTIONBODY** dwg_getall_ASSOCROTATEDDIMACTIONBODY (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCSWEPTSURFACEACTIONBODY** dwg_getall_ASSOCSWEPTSURFACEACTIONBODY (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCVARIABLE** dwg_getall_ASSOCVARIABLE (Dwg_Data* dwg);
EXPORT Dwg_Object_ASSOCVERTEXACTIONPARAM** dwg_getall_ASSOCVERTEXACTIONPARAM (Dwg_Data* dwg);
EXPORT Dwg_Object_BLKREFOBJECTCONTEXTDATA** dwg_getall_BLKREFOBJECTCONTEXTDATA (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKALIGNEDCONSTRAINTPARAMETER** dwg_getall_BLOCKALIGNEDCONSTRAINTPARAMETER (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKALIGNMENTGRIP** dwg_getall_BLOCKALIGNMENTGRIP (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKALIGNMENTPARAMETER** dwg_getall_BLOCKALIGNMENTPARAMETER (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKANGULARCONSTRAINTPARAMETER** dwg_getall_BLOCKANGULARCONSTRAINTPARAMETER (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKARRAYACTION** dwg_getall_BLOCKARRAYACTION (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKBASEPOINTPARAMETER** dwg_getall_BLOCKBASEPOINTPARAMETER (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKDIAMETRICCONSTRAINTPARAMETER** dwg_getall_BLOCKDIAMETRICCONSTRAINTPARAMETER (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKFLIPACTION** dwg_getall_BLOCKFLIPACTION (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKFLIPGRIP** dwg_getall_BLOCKFLIPGRIP (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKFLIPPARAMETER** dwg_getall_BLOCKFLIPPARAMETER (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKHORIZONTALCONSTRAINTPARAMETER** dwg_getall_BLOCKHORIZONTALCONSTRAINTPARAMETER (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKLINEARCONSTRAINTPARAMETER** dwg_getall_BLOCKLINEARCONSTRAINTPARAMETER (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKLINEARGRIP** dwg_getall_BLOCKLINEARGRIP (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKLINEARPARAMETER** dwg_getall_BLOCKLINEARPARAMETER (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKLOOKUPACTION** dwg_getall_BLOCKLOOKUPACTION (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKLOOKUPGRIP** dwg_getall_BLOCKLOOKUPGRIP (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKLOOKUPPARAMETER** dwg_getall_BLOCKLOOKUPPARAMETER (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKMOVEACTION** dwg_getall_BLOCKMOVEACTION (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKPARAMDEPENDENCYBODY** dwg_getall_BLOCKPARAMDEPENDENCYBODY (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKPOINTPARAMETER** dwg_getall_BLOCKPOINTPARAMETER (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKPOLARGRIP** dwg_getall_BLOCKPOLARGRIP (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKPOLARPARAMETER** dwg_getall_BLOCKPOLARPARAMETER (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKPOLARSTRETCHACTION** dwg_getall_BLOCKPOLARSTRETCHACTION (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKPROPERTIESTABLE** dwg_getall_BLOCKPROPERTIESTABLE (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKPROPERTIESTABLEGRIP** dwg_getall_BLOCKPROPERTIESTABLEGRIP (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKRADIALCONSTRAINTPARAMETER** dwg_getall_BLOCKRADIALCONSTRAINTPARAMETER (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKREPRESENTATION** dwg_getall_BLOCKREPRESENTATION (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKROTATEACTION** dwg_getall_BLOCKROTATEACTION (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKROTATIONGRIP** dwg_getall_BLOCKROTATIONGRIP (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKROTATIONPARAMETER** dwg_getall_BLOCKROTATIONPARAMETER (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKSCALEACTION** dwg_getall_BLOCKSCALEACTION (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKSTRETCHACTION** dwg_getall_BLOCKSTRETCHACTION (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKUSERPARAMETER** dwg_getall_BLOCKUSERPARAMETER (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKVERTICALCONSTRAINTPARAMETER** dwg_getall_BLOCKVERTICALCONSTRAINTPARAMETER (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKVISIBILITYPARAMETER** dwg_getall_BLOCKVISIBILITYPARAMETER (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKXYGRIP** dwg_getall_BLOCKXYGRIP (Dwg_Data* dwg);
EXPORT Dwg_Object_BLOCKXYPARAMETER** dwg_getall_BLOCKXYPARAMETER (Dwg_Data* dwg);
EXPORT Dwg_Object_CONTEXTDATAMANAGER** dwg_getall_CONTEXTDATAMANAGER (Dwg_Data* dwg);
EXPORT Dwg_Object_CSACDOCUMENTOPTIONS** dwg_getall_CSACDOCUMENTOPTIONS (Dwg_Data* dwg);
EXPORT Dwg_Object_CURVEPATH** dwg_getall_CURVEPATH (Dwg_Data* dwg);
EXPORT Dwg_Object_DATALINK** dwg_getall_DATALINK (Dwg_Data* dwg);
EXPORT Dwg_Object_DATATABLE** dwg_getall_DATATABLE (Dwg_Data* dwg);
EXPORT Dwg_Object_DMDIMOBJECTCONTEXTDATA** dwg_getall_DMDIMOBJECTCONTEXTDATA (Dwg_Data* dwg);
EXPORT Dwg_Object_DYNAMICBLOCKPROXYNODE** dwg_getall_DYNAMICBLOCKPROXYNODE (Dwg_Data* dwg);
EXPORT Dwg_Object_EVALUATION_GRAPH** dwg_getall_EVALUATION_GRAPH (Dwg_Data* dwg);
EXPORT Dwg_Object_FCFOBJECTCONTEXTDATA** dwg_getall_FCFOBJECTCONTEXTDATA (Dwg_Data* dwg);
EXPORT Dwg_Object_GEOMAPIMAGE** dwg_getall_GEOMAPIMAGE (Dwg_Data* dwg);
EXPORT Dwg_Object_LAYOUTPRINTCONFIG** dwg_getall_LAYOUTPRINTCONFIG (Dwg_Data* dwg);
EXPORT Dwg_Object_LEADEROBJECTCONTEXTDATA** dwg_getall_LEADEROBJECTCONTEXTDATA (Dwg_Data* dwg);
EXPORT Dwg_Object_MLEADEROBJECTCONTEXTDATA** dwg_getall_MLEADEROBJECTCONTEXTDATA (Dwg_Data* dwg);
EXPORT Dwg_Object_MOTIONPATH** dwg_getall_MOTIONPATH (Dwg_Data* dwg);
EXPORT Dwg_Object_MTEXTATTRIBUTEOBJECTCONTEXTDATA** dwg_getall_MTEXTATTRIBUTEOBJECTCONTEXTDATA (Dwg_Data* dwg);
EXPORT Dwg_Object_MTEXTOBJECTCONTEXTDATA** dwg_getall_MTEXTOBJECTCONTEXTDATA (Dwg_Data* dwg);
EXPORT Dwg_Object_NAVISWORKSMODELDEF** dwg_getall_NAVISWORKSMODELDEF (Dwg_Data* dwg);
EXPORT Dwg_Object_OBJECTCONTEXTDATA** dwg_getall_OBJECTCONTEXTDATA (Dwg_Data* dwg);
EXPORT Dwg_Object_ORDDIMOBJECTCONTEXTDATA** dwg_getall_ORDDIMOBJECTCONTEXTDATA (Dwg_Data* dwg);
EXPORT Dwg_Object_PERSUBENTMGR** dwg_getall_PERSUBENTMGR (Dwg_Data* dwg);
EXPORT Dwg_Object_POINTPATH** dwg_getall_POINTPATH (Dwg_Data* dwg);
EXPORT Dwg_Object_RADIMLGOBJECTCONTEXTDATA** dwg_getall_RADIMLGOBJECTCONTEXTDATA (Dwg_Data* dwg);
EXPORT Dwg_Object_RADIMOBJECTCONTEXTDATA** dwg_getall_RADIMOBJECTCONTEXTDATA (Dwg_Data* dwg);
EXPORT Dwg_Object_RENDERENTRY** dwg_getall_RENDERENTRY (Dwg_Data* dwg);
EXPORT Dwg_Object_RENDERENVIRONMENT** dwg_getall_RENDERENVIRONMENT (Dwg_Data* dwg);
EXPORT Dwg_Object_RENDERGLOBAL** dwg_getall_RENDERGLOBAL (Dwg_Data* dwg);
EXPORT Dwg_Object_SUNSTUDY** dwg_getall_SUNSTUDY (Dwg_Data* dwg);
EXPORT Dwg_Object_TABLECONTENT** dwg_getall_TABLECONTENT (Dwg_Data* dwg);
EXPORT Dwg_Object_TEXTOBJECTCONTEXTDATA** dwg_getall_TEXTOBJECTCONTEXTDATA (Dwg_Data* dwg);
EXPORT Dwg_Object_TVDEVICEPROPERTIES** dwg_getall_TVDEVICEPROPERTIES (Dwg_Data* dwg);
#endif

/* dwg_object_to_ API */
EXPORT Dwg_Entity_ARC* dwg_object_to_ARC (Dwg_Object* obj);
EXPORT Dwg_Entity_ATTDEF* dwg_object_to_ATTDEF (Dwg_Object* obj);
EXPORT Dwg_Entity_ATTRIB* dwg_object_to_ATTRIB (Dwg_Object* obj);
EXPORT Dwg_Entity_BLOCK* dwg_object_to_BLOCK (Dwg_Object* obj);
EXPORT Dwg_Entity_BODY* dwg_object_to_BODY (Dwg_Object* obj);
EXPORT Dwg_Entity_CAMERA* dwg_object_to_CAMERA (Dwg_Object* obj);
EXPORT Dwg_Entity_CIRCLE* dwg_object_to_CIRCLE (Dwg_Object* obj);
EXPORT Dwg_Entity_DIMENSION_ALIGNED* dwg_object_to_DIMENSION_ALIGNED (Dwg_Object* obj);
EXPORT Dwg_Entity_DIMENSION_ANG2LN* dwg_object_to_DIMENSION_ANG2LN (Dwg_Object* obj);
EXPORT Dwg_Entity_DIMENSION_ANG3PT* dwg_object_to_DIMENSION_ANG3PT (Dwg_Object* obj);
EXPORT Dwg_Entity_DIMENSION_DIAMETER* dwg_object_to_DIMENSION_DIAMETER (Dwg_Object* obj);
EXPORT Dwg_Entity_DIMENSION_LINEAR* dwg_object_to_DIMENSION_LINEAR (Dwg_Object* obj);
EXPORT Dwg_Entity_DIMENSION_ORDINATE* dwg_object_to_DIMENSION_ORDINATE (Dwg_Object* obj);
EXPORT Dwg_Entity_DIMENSION_RADIUS* dwg_object_to_DIMENSION_RADIUS (Dwg_Object* obj);
EXPORT Dwg_Entity_ELLIPSE* dwg_object_to_ELLIPSE (Dwg_Object* obj);
EXPORT Dwg_Entity_ENDBLK* dwg_object_to_ENDBLK (Dwg_Object* obj);
EXPORT Dwg_Entity_HATCH* dwg_object_to_HATCH (Dwg_Object* obj);
EXPORT Dwg_Entity_IMAGE* dwg_object_to_IMAGE (Dwg_Object* obj);
EXPORT Dwg_Entity_INSERT* dwg_object_to_INSERT (Dwg_Object* obj);
EXPORT Dwg_Entity_LEADER* dwg_object_to_LEADER (Dwg_Object* obj);
EXPORT Dwg_Entity_LIGHT* dwg_object_to_LIGHT (Dwg_Object* obj);
EXPORT Dwg_Entity_LINE* dwg_object_to_LINE (Dwg_Object* obj);
EXPORT Dwg_Entity_LWPOLYLINE* dwg_object_to_LWPOLYLINE (Dwg_Object* obj);
EXPORT Dwg_Entity_MESH* dwg_object_to_MESH (Dwg_Object* obj);
EXPORT Dwg_Entity_MINSERT* dwg_object_to_MINSERT (Dwg_Object* obj);
EXPORT Dwg_Entity_MLINE* dwg_object_to_MLINE (Dwg_Object* obj);
EXPORT Dwg_Entity_MTEXT* dwg_object_to_MTEXT (Dwg_Object* obj);
EXPORT Dwg_Entity_MULTILEADER* dwg_object_to_MULTILEADER (Dwg_Object* obj);
EXPORT Dwg_Entity_OLE2FRAME* dwg_object_to_OLE2FRAME (Dwg_Object* obj);
EXPORT Dwg_Entity_OLEFRAME* dwg_object_to_OLEFRAME (Dwg_Object* obj);
EXPORT Dwg_Entity_POINT* dwg_object_to_POINT (Dwg_Object* obj);
EXPORT Dwg_Entity_POLYLINE_2D* dwg_object_to_POLYLINE_2D (Dwg_Object* obj);
EXPORT Dwg_Entity_POLYLINE_3D* dwg_object_to_POLYLINE_3D (Dwg_Object* obj);
EXPORT Dwg_Entity_POLYLINE_MESH* dwg_object_to_POLYLINE_MESH (Dwg_Object* obj);
EXPORT Dwg_Entity_POLYLINE_PFACE* dwg_object_to_POLYLINE_PFACE (Dwg_Object* obj);
EXPORT Dwg_Entity_PROXY_ENTITY* dwg_object_to_PROXY_ENTITY (Dwg_Object* obj);
EXPORT Dwg_Entity_RAY* dwg_object_to_RAY (Dwg_Object* obj);
EXPORT Dwg_Entity_REGION* dwg_object_to_REGION (Dwg_Object* obj);
EXPORT Dwg_Entity_SECTIONOBJECT* dwg_object_to_SECTIONOBJECT (Dwg_Object* obj);
EXPORT Dwg_Entity_SEQEND* dwg_object_to_SEQEND (Dwg_Object* obj);
EXPORT Dwg_Entity_SHAPE* dwg_object_to_SHAPE (Dwg_Object* obj);
EXPORT Dwg_Entity_SOLID* dwg_object_to_SOLID (Dwg_Object* obj);
EXPORT Dwg_Entity_SPLINE* dwg_object_to_SPLINE (Dwg_Object* obj);
EXPORT Dwg_Entity_TEXT* dwg_object_to_TEXT (Dwg_Object* obj);
EXPORT Dwg_Entity_TOLERANCE* dwg_object_to_TOLERANCE (Dwg_Object* obj);
EXPORT Dwg_Entity_TRACE* dwg_object_to_TRACE (Dwg_Object* obj);
EXPORT Dwg_Entity_UNDERLAY* dwg_object_to_UNDERLAY (Dwg_Object* obj);
EXPORT Dwg_Entity_UNKNOWN_ENT* dwg_object_to_UNKNOWN_ENT (Dwg_Object* obj);
EXPORT Dwg_Entity_VERTEX_2D* dwg_object_to_VERTEX_2D (Dwg_Object* obj);
EXPORT Dwg_Entity_VERTEX_3D* dwg_object_to_VERTEX_3D (Dwg_Object* obj);
EXPORT Dwg_Entity_VERTEX_MESH* dwg_object_to_VERTEX_MESH (Dwg_Object* obj);
EXPORT Dwg_Entity_VERTEX_PFACE* dwg_object_to_VERTEX_PFACE (Dwg_Object* obj);
EXPORT Dwg_Entity_VERTEX_PFACE_FACE* dwg_object_to_VERTEX_PFACE_FACE (Dwg_Object* obj);
EXPORT Dwg_Entity_VIEWPORT* dwg_object_to_VIEWPORT (Dwg_Object* obj);
EXPORT Dwg_Entity_WIPEOUT* dwg_object_to_WIPEOUT (Dwg_Object* obj);
EXPORT Dwg_Entity_XLINE* dwg_object_to_XLINE (Dwg_Object* obj);
/* unstable */
EXPORT Dwg_Entity_ARC_DIMENSION* dwg_object_to_ARC_DIMENSION (Dwg_Object* obj);
EXPORT Dwg_Entity_HELIX* dwg_object_to_HELIX (Dwg_Object* obj);
EXPORT Dwg_Entity_LARGE_RADIAL_DIMENSION* dwg_object_to_LARGE_RADIAL_DIMENSION (Dwg_Object* obj);
#ifdef DEBUG_CLASSES
  EXPORT Dwg_Entity_ALIGNMENTPARAMETERENTITY* dwg_object_to_ALIGNMENTPARAMETERENTITY (Dwg_Object* obj);
  EXPORT Dwg_Entity_ATEXT* dwg_object_to_ATEXT (Dwg_Object* obj);
  EXPORT Dwg_Entity_BASEPOINTPARAMETERENTITY* dwg_object_to_BASEPOINTPARAMETERENTITY (Dwg_Object* obj);
  EXPORT Dwg_Entity_EXTRUDEDSURFACE* dwg_object_to_EXTRUDEDSURFACE (Dwg_Object* obj);
  EXPORT Dwg_Entity_FLIPPARAMETERENTITY* dwg_object_to_FLIPPARAMETERENTITY (Dwg_Object* obj);
  EXPORT Dwg_Entity_GEOPOSITIONMARKER* dwg_object_to_GEOPOSITIONMARKER (Dwg_Object* obj);
  EXPORT Dwg_Entity_LINEARPARAMETERENTITY* dwg_object_to_LINEARPARAMETERENTITY (Dwg_Object* obj);
  EXPORT Dwg_Entity_LOFTEDSURFACE* dwg_object_to_LOFTEDSURFACE (Dwg_Object* obj);
  EXPORT Dwg_Entity_MPOLYGON* dwg_object_to_MPOLYGON (Dwg_Object* obj);
  EXPORT Dwg_Entity_NAVISWORKSMODEL* dwg_object_to_NAVISWORKSMODEL (Dwg_Object* obj);
  EXPORT Dwg_Entity_NURBSURFACE* dwg_object_to_NURBSURFACE (Dwg_Object* obj);
  EXPORT Dwg_Entity_PLANESURFACE* dwg_object_to_PLANESURFACE (Dwg_Object* obj);
  EXPORT Dwg_Entity_POINTPARAMETERENTITY* dwg_object_to_POINTPARAMETERENTITY (Dwg_Object* obj);
  EXPORT Dwg_Entity_REVOLVEDSURFACE* dwg_object_to_REVOLVEDSURFACE (Dwg_Object* obj);
  EXPORT Dwg_Entity_ROTATIONPARAMETERENTITY* dwg_object_to_ROTATIONPARAMETERENTITY (Dwg_Object* obj);
  EXPORT Dwg_Entity_RTEXT* dwg_object_to_RTEXT (Dwg_Object* obj);
  EXPORT Dwg_Entity_SWEPTSURFACE* dwg_object_to_SWEPTSURFACE (Dwg_Object* obj);
  EXPORT Dwg_Entity_TABLE* dwg_object_to_TABLE (Dwg_Object* obj);
  EXPORT Dwg_Entity_VISIBILITYGRIPENTITY* dwg_object_to_VISIBILITYGRIPENTITY (Dwg_Object* obj);
  EXPORT Dwg_Entity_VISIBILITYPARAMETERENTITY* dwg_object_to_VISIBILITYPARAMETERENTITY (Dwg_Object* obj);
  EXPORT Dwg_Entity_XYPARAMETERENTITY* dwg_object_to_XYPARAMETERENTITY (Dwg_Object* obj);
#endif
EXPORT Dwg_Object_ACSH_BOOLEAN_CLASS* dwg_object_to_ACSH_BOOLEAN_CLASS (Dwg_Object* obj);
EXPORT Dwg_Object_ACSH_BOX_CLASS* dwg_object_to_ACSH_BOX_CLASS (Dwg_Object* obj);
EXPORT Dwg_Object_ACSH_CYLINDER_CLASS* dwg_object_to_ACSH_CYLINDER_CLASS (Dwg_Object* obj);
EXPORT Dwg_Object_ACSH_FILLET_CLASS* dwg_object_to_ACSH_FILLET_CLASS (Dwg_Object* obj);
EXPORT Dwg_Object_ACSH_SPHERE_CLASS* dwg_object_to_ACSH_SPHERE_CLASS (Dwg_Object* obj);
EXPORT Dwg_Object_ACSH_WEDGE_CLASS* dwg_object_to_ACSH_WEDGE_CLASS (Dwg_Object* obj);
EXPORT Dwg_Object_APPID* dwg_object_to_APPID (Dwg_Object* obj);
EXPORT Dwg_Object_APPID_CONTROL* dwg_object_to_APPID_CONTROL (Dwg_Object* obj);
EXPORT Dwg_Object_BLOCK_CONTROL* dwg_object_to_BLOCK_CONTROL (Dwg_Object* obj);
EXPORT Dwg_Object_BLOCK_HEADER* dwg_object_to_BLOCK_HEADER (Dwg_Object* obj);
EXPORT Dwg_Object_CELLSTYLEMAP* dwg_object_to_CELLSTYLEMAP (Dwg_Object* obj);
EXPORT Dwg_Object_DICTIONARY* dwg_object_to_DICTIONARY (Dwg_Object* obj);
EXPORT Dwg_Object_DICTIONARYVAR* dwg_object_to_DICTIONARYVAR (Dwg_Object* obj);
EXPORT Dwg_Object_DICTIONARYWDFLT* dwg_object_to_DICTIONARYWDFLT (Dwg_Object* obj);
EXPORT Dwg_Object_DIMSTYLE* dwg_object_to_DIMSTYLE (Dwg_Object* obj);
EXPORT Dwg_Object_DIMSTYLE_CONTROL* dwg_object_to_DIMSTYLE_CONTROL (Dwg_Object* obj);
EXPORT Dwg_Object_DUMMY* dwg_object_to_DUMMY (Dwg_Object* obj);
EXPORT Dwg_Object_DYNAMICBLOCKPURGEPREVENTER* dwg_object_to_DYNAMICBLOCKPURGEPREVENTER (Dwg_Object* obj);
EXPORT Dwg_Object_FIELD* dwg_object_to_FIELD (Dwg_Object* obj);
EXPORT Dwg_Object_FIELDLIST* dwg_object_to_FIELDLIST (Dwg_Object* obj);
EXPORT Dwg_Object_GEODATA* dwg_object_to_GEODATA (Dwg_Object* obj);
EXPORT Dwg_Object_GROUP* dwg_object_to_GROUP (Dwg_Object* obj);
EXPORT Dwg_Object_IDBUFFER* dwg_object_to_IDBUFFER (Dwg_Object* obj);
EXPORT Dwg_Object_IMAGEDEF* dwg_object_to_IMAGEDEF (Dwg_Object* obj);
EXPORT Dwg_Object_IMAGEDEF_REACTOR* dwg_object_to_IMAGEDEF_REACTOR (Dwg_Object* obj);
EXPORT Dwg_Object_INDEX* dwg_object_to_INDEX (Dwg_Object* obj);
EXPORT Dwg_Object_LAYER* dwg_object_to_LAYER (Dwg_Object* obj);
EXPORT Dwg_Object_LAYERFILTER* dwg_object_to_LAYERFILTER (Dwg_Object* obj);
EXPORT Dwg_Object_LAYER_CONTROL* dwg_object_to_LAYER_CONTROL (Dwg_Object* obj);
EXPORT Dwg_Object_LAYER_INDEX* dwg_object_to_LAYER_INDEX (Dwg_Object* obj);
EXPORT Dwg_Object_LAYOUT* dwg_object_to_LAYOUT (Dwg_Object* obj);
EXPORT Dwg_Object_LONG_TRANSACTION* dwg_object_to_LONG_TRANSACTION (Dwg_Object* obj);
EXPORT Dwg_Object_LTYPE* dwg_object_to_LTYPE (Dwg_Object* obj);
EXPORT Dwg_Object_LTYPE_CONTROL* dwg_object_to_LTYPE_CONTROL (Dwg_Object* obj);
EXPORT Dwg_Object_MLEADERSTYLE* dwg_object_to_MLEADERSTYLE (Dwg_Object* obj);
EXPORT Dwg_Object_MLINESTYLE* dwg_object_to_MLINESTYLE (Dwg_Object* obj);
EXPORT Dwg_Object_PLACEHOLDER* dwg_object_to_PLACEHOLDER (Dwg_Object* obj);
EXPORT Dwg_Object_PLOTSETTINGS* dwg_object_to_PLOTSETTINGS (Dwg_Object* obj);
EXPORT Dwg_Object_RASTERVARIABLES* dwg_object_to_RASTERVARIABLES (Dwg_Object* obj);
EXPORT Dwg_Object_SCALE* dwg_object_to_SCALE (Dwg_Object* obj);
EXPORT Dwg_Object_SECTION_MANAGER* dwg_object_to_SECTION_MANAGER (Dwg_Object* obj);
EXPORT Dwg_Object_SORTENTSTABLE* dwg_object_to_SORTENTSTABLE (Dwg_Object* obj);
EXPORT Dwg_Object_SPATIAL_FILTER* dwg_object_to_SPATIAL_FILTER (Dwg_Object* obj);
EXPORT Dwg_Object_STYLE* dwg_object_to_STYLE (Dwg_Object* obj);
EXPORT Dwg_Object_STYLE_CONTROL* dwg_object_to_STYLE_CONTROL (Dwg_Object* obj);
EXPORT Dwg_Object_TABLEGEOMETRY* dwg_object_to_TABLEGEOMETRY (Dwg_Object* obj);
EXPORT Dwg_Object_UCS* dwg_object_to_UCS (Dwg_Object* obj);
EXPORT Dwg_Object_UCS_CONTROL* dwg_object_to_UCS_CONTROL (Dwg_Object* obj);
EXPORT Dwg_Object_UNDERLAYDEFINITION* dwg_object_to_UNDERLAYDEFINITION (Dwg_Object* obj);
EXPORT Dwg_Object_UNKNOWN_OBJ* dwg_object_to_UNKNOWN_OBJ (Dwg_Object* obj);
EXPORT Dwg_Object_VBA_PROJECT* dwg_object_to_VBA_PROJECT (Dwg_Object* obj);
EXPORT Dwg_Object_VIEW* dwg_object_to_VIEW (Dwg_Object* obj);
EXPORT Dwg_Object_VIEW_CONTROL* dwg_object_to_VIEW_CONTROL (Dwg_Object* obj);
EXPORT Dwg_Object_VISUALSTYLE* dwg_object_to_VISUALSTYLE (Dwg_Object* obj);
EXPORT Dwg_Object_VPORT* dwg_object_to_VPORT (Dwg_Object* obj);
EXPORT Dwg_Object_VPORT_CONTROL* dwg_object_to_VPORT_CONTROL (Dwg_Object* obj);
EXPORT Dwg_Object_VPORT_ENTITY_CONTROL* dwg_object_to_VPORT_ENTITY_CONTROL (Dwg_Object* obj);
EXPORT Dwg_Object_VPORT_ENTITY_HEADER* dwg_object_to_VPORT_ENTITY_HEADER (Dwg_Object* obj);
EXPORT Dwg_Object_WIPEOUTVARIABLES* dwg_object_to_WIPEOUTVARIABLES (Dwg_Object* obj);
EXPORT Dwg_Object_XRECORD* dwg_object_to_XRECORD (Dwg_Object* obj);
/* unstable */
EXPORT Dwg_Object_ACSH_BREP_CLASS* dwg_object_to_ACSH_BREP_CLASS (Dwg_Object* obj);
EXPORT Dwg_Object_ACSH_CHAMFER_CLASS* dwg_object_to_ACSH_CHAMFER_CLASS (Dwg_Object* obj);
EXPORT Dwg_Object_ACSH_CONE_CLASS* dwg_object_to_ACSH_CONE_CLASS (Dwg_Object* obj);
EXPORT Dwg_Object_ACSH_PYRAMID_CLASS* dwg_object_to_ACSH_PYRAMID_CLASS (Dwg_Object* obj);
EXPORT Dwg_Object_ACSH_TORUS_CLASS* dwg_object_to_ACSH_TORUS_CLASS (Dwg_Object* obj);
EXPORT Dwg_Object_ASSOCACTION* dwg_object_to_ASSOCACTION (Dwg_Object* obj);
EXPORT Dwg_Object_ASSOCBLENDSURFACEACTIONBODY* dwg_object_to_ASSOCBLENDSURFACEACTIONBODY (Dwg_Object* obj);
EXPORT Dwg_Object_ASSOCDEPENDENCY* dwg_object_to_ASSOCDEPENDENCY (Dwg_Object* obj);
EXPORT Dwg_Object_ASSOCEXTENDSURFACEACTIONBODY* dwg_object_to_ASSOCEXTENDSURFACEACTIONBODY (Dwg_Object* obj);
EXPORT Dwg_Object_ASSOCEXTRUDEDSURFACEACTIONBODY* dwg_object_to_ASSOCEXTRUDEDSURFACEACTIONBODY (Dwg_Object* obj);
EXPORT Dwg_Object_ASSOCFILLETSURFACEACTIONBODY* dwg_object_to_ASSOCFILLETSURFACEACTIONBODY (Dwg_Object* obj);
EXPORT Dwg_Object_ASSOCGEOMDEPENDENCY* dwg_object_to_ASSOCGEOMDEPENDENCY (Dwg_Object* obj);
EXPORT Dwg_Object_ASSOCLOFTEDSURFACEACTIONBODY* dwg_object_to_ASSOCLOFTEDSURFACEACTIONBODY (Dwg_Object* obj);
EXPORT Dwg_Object_ASSOCNETWORK* dwg_object_to_ASSOCNETWORK (Dwg_Object* obj);
EXPORT Dwg_Object_ASSOCNETWORKSURFACEACTIONBODY* dwg_object_to_ASSOCNETWORKSURFACEACTIONBODY (Dwg_Object* obj);
EXPORT Dwg_Object_ASSOCOFFSETSURFACEACTIONBODY* dwg_object_to_ASSOCOFFSETSURFACEACTIONBODY (Dwg_Object* obj);
EXPORT Dwg_Object_ASSOCPATCHSURFACEACTIONBODY* dwg_object_to_ASSOCPATCHSURFACEACTIONBODY (Dwg_Object* obj);
EXPORT Dwg_Object_ASSOCPLANESURFACEACTIONBODY* dwg_object_to_ASSOCPLANESURFACEACTIONBODY (Dwg_Object* obj);
EXPORT Dwg_Object_ASSOCREVOLVEDSURFACEACTIONBODY* dwg_object_to_ASSOCREVOLVEDSURFACEACTIONBODY (Dwg_Object* obj);
EXPORT Dwg_Object_ASSOCTRIMSURFACEACTIONBODY* dwg_object_to_ASSOCTRIMSURFACEACTIONBODY (Dwg_Object* obj);
EXPORT Dwg_Object_ASSOCVALUEDEPENDENCY* dwg_object_to_ASSOCVALUEDEPENDENCY (Dwg_Object* obj);
EXPORT Dwg_Object_BACKGROUND* dwg_object_to_BACKGROUND (Dwg_Object* obj);
EXPORT Dwg_Object_BLOCKGRIPLOCATIONCOMPONENT* dwg_object_to_BLOCKGRIPLOCATIONCOMPONENT (Dwg_Object* obj);
EXPORT Dwg_Object_BLOCKVISIBILITYGRIP* dwg_object_to_BLOCKVISIBILITYGRIP (Dwg_Object* obj);
EXPORT Dwg_Object_DBCOLOR* dwg_object_to_DBCOLOR (Dwg_Object* obj);
EXPORT Dwg_Object_DETAILVIEWSTYLE* dwg_object_to_DETAILVIEWSTYLE (Dwg_Object* obj);
EXPORT Dwg_Object_DIMASSOC* dwg_object_to_DIMASSOC (Dwg_Object* obj);
EXPORT Dwg_Object_LIGHTLIST* dwg_object_to_LIGHTLIST (Dwg_Object* obj);
EXPORT Dwg_Object_MATERIAL* dwg_object_to_MATERIAL (Dwg_Object* obj);
EXPORT Dwg_Object_MENTALRAYRENDERSETTINGS* dwg_object_to_MENTALRAYRENDERSETTINGS (Dwg_Object* obj);
EXPORT Dwg_Object_OBJECT_PTR* dwg_object_to_OBJECT_PTR (Dwg_Object* obj);
EXPORT Dwg_Object_PROXY_OBJECT* dwg_object_to_PROXY_OBJECT (Dwg_Object* obj);
EXPORT Dwg_Object_RAPIDRTRENDERSETTINGS* dwg_object_to_RAPIDRTRENDERSETTINGS (Dwg_Object* obj);
EXPORT Dwg_Object_RENDERSETTINGS* dwg_object_to_RENDERSETTINGS (Dwg_Object* obj);
EXPORT Dwg_Object_SECTIONVIEWSTYLE* dwg_object_to_SECTIONVIEWSTYLE (Dwg_Object* obj);
EXPORT Dwg_Object_SECTION_SETTINGS* dwg_object_to_SECTION_SETTINGS (Dwg_Object* obj);
EXPORT Dwg_Object_SPATIAL_INDEX* dwg_object_to_SPATIAL_INDEX (Dwg_Object* obj);
EXPORT Dwg_Object_SUN* dwg_object_to_SUN (Dwg_Object* obj);
EXPORT Dwg_Object_TABLESTYLE* dwg_object_to_TABLESTYLE (Dwg_Object* obj);
#ifdef DEBUG_CLASSES
  EXPORT Dwg_Object_ACMECOMMANDHISTORY* dwg_object_to_ACMECOMMANDHISTORY (Dwg_Object* obj);
  EXPORT Dwg_Object_ACMESCOPE* dwg_object_to_ACMESCOPE (Dwg_Object* obj);
  EXPORT Dwg_Object_ACMESTATEMGR* dwg_object_to_ACMESTATEMGR (Dwg_Object* obj);
  EXPORT Dwg_Object_ACSH_EXTRUSION_CLASS* dwg_object_to_ACSH_EXTRUSION_CLASS (Dwg_Object* obj);
  EXPORT Dwg_Object_ACSH_HISTORY_CLASS* dwg_object_to_ACSH_HISTORY_CLASS (Dwg_Object* obj);
  EXPORT Dwg_Object_ACSH_LOFT_CLASS* dwg_object_to_ACSH_LOFT_CLASS (Dwg_Object* obj);
  EXPORT Dwg_Object_ACSH_REVOLVE_CLASS* dwg_object_to_ACSH_REVOLVE_CLASS (Dwg_Object* obj);
  EXPORT Dwg_Object_ACSH_SWEEP_CLASS* dwg_object_to_ACSH_SWEEP_CLASS (Dwg_Object* obj);
  EXPORT Dwg_Object_ALDIMOBJECTCONTEXTDATA* dwg_object_to_ALDIMOBJECTCONTEXTDATA (Dwg_Object* obj);
  EXPORT Dwg_Object_ANGDIMOBJECTCONTEXTDATA* dwg_object_to_ANGDIMOBJECTCONTEXTDATA (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOC2DCONSTRAINTGROUP* dwg_object_to_ASSOC2DCONSTRAINTGROUP (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOC3POINTANGULARDIMACTIONBODY* dwg_object_to_ASSOC3POINTANGULARDIMACTIONBODY (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOCACTIONPARAM* dwg_object_to_ASSOCACTIONPARAM (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOCALIGNEDDIMACTIONBODY* dwg_object_to_ASSOCALIGNEDDIMACTIONBODY (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOCARRAYACTIONBODY* dwg_object_to_ASSOCARRAYACTIONBODY (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOCARRAYMODIFYACTIONBODY* dwg_object_to_ASSOCARRAYMODIFYACTIONBODY (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOCARRAYMODIFYPARAMETERS* dwg_object_to_ASSOCARRAYMODIFYPARAMETERS (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOCARRAYPATHPARAMETERS* dwg_object_to_ASSOCARRAYPATHPARAMETERS (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOCARRAYPOLARPARAMETERS* dwg_object_to_ASSOCARRAYPOLARPARAMETERS (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOCARRAYRECTANGULARPARAMETERS* dwg_object_to_ASSOCARRAYRECTANGULARPARAMETERS (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOCASMBODYACTIONPARAM* dwg_object_to_ASSOCASMBODYACTIONPARAM (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOCCOMPOUNDACTIONPARAM* dwg_object_to_ASSOCCOMPOUNDACTIONPARAM (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOCDIMDEPENDENCYBODY* dwg_object_to_ASSOCDIMDEPENDENCYBODY (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOCEDGEACTIONPARAM* dwg_object_to_ASSOCEDGEACTIONPARAM (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOCEDGECHAMFERACTIONBODY* dwg_object_to_ASSOCEDGECHAMFERACTIONBODY (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOCEDGEFILLETACTIONBODY* dwg_object_to_ASSOCEDGEFILLETACTIONBODY (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOCFACEACTIONPARAM* dwg_object_to_ASSOCFACEACTIONPARAM (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOCMLEADERACTIONBODY* dwg_object_to_ASSOCMLEADERACTIONBODY (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOCOBJECTACTIONPARAM* dwg_object_to_ASSOCOBJECTACTIONPARAM (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOCORDINATEDIMACTIONBODY* dwg_object_to_ASSOCORDINATEDIMACTIONBODY (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOCOSNAPPOINTREFACTIONPARAM* dwg_object_to_ASSOCOSNAPPOINTREFACTIONPARAM (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOCPATHACTIONPARAM* dwg_object_to_ASSOCPATHACTIONPARAM (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOCPERSSUBENTMANAGER* dwg_object_to_ASSOCPERSSUBENTMANAGER (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOCPOINTREFACTIONPARAM* dwg_object_to_ASSOCPOINTREFACTIONPARAM (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOCRESTOREENTITYSTATEACTIONBODY* dwg_object_to_ASSOCRESTOREENTITYSTATEACTIONBODY (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOCROTATEDDIMACTIONBODY* dwg_object_to_ASSOCROTATEDDIMACTIONBODY (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOCSWEPTSURFACEACTIONBODY* dwg_object_to_ASSOCSWEPTSURFACEACTIONBODY (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOCVARIABLE* dwg_object_to_ASSOCVARIABLE (Dwg_Object* obj);
  EXPORT Dwg_Object_ASSOCVERTEXACTIONPARAM* dwg_object_to_ASSOCVERTEXACTIONPARAM (Dwg_Object* obj);
  EXPORT Dwg_Object_BLKREFOBJECTCONTEXTDATA* dwg_object_to_BLKREFOBJECTCONTEXTDATA (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKALIGNEDCONSTRAINTPARAMETER* dwg_object_to_BLOCKALIGNEDCONSTRAINTPARAMETER (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKALIGNMENTGRIP* dwg_object_to_BLOCKALIGNMENTGRIP (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKALIGNMENTPARAMETER* dwg_object_to_BLOCKALIGNMENTPARAMETER (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKANGULARCONSTRAINTPARAMETER* dwg_object_to_BLOCKANGULARCONSTRAINTPARAMETER (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKARRAYACTION* dwg_object_to_BLOCKARRAYACTION (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKBASEPOINTPARAMETER* dwg_object_to_BLOCKBASEPOINTPARAMETER (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKDIAMETRICCONSTRAINTPARAMETER* dwg_object_to_BLOCKDIAMETRICCONSTRAINTPARAMETER (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKFLIPACTION* dwg_object_to_BLOCKFLIPACTION (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKFLIPGRIP* dwg_object_to_BLOCKFLIPGRIP (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKFLIPPARAMETER* dwg_object_to_BLOCKFLIPPARAMETER (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKHORIZONTALCONSTRAINTPARAMETER* dwg_object_to_BLOCKHORIZONTALCONSTRAINTPARAMETER (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKLINEARCONSTRAINTPARAMETER* dwg_object_to_BLOCKLINEARCONSTRAINTPARAMETER (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKLINEARGRIP* dwg_object_to_BLOCKLINEARGRIP (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKLINEARPARAMETER* dwg_object_to_BLOCKLINEARPARAMETER (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKLOOKUPACTION* dwg_object_to_BLOCKLOOKUPACTION (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKLOOKUPGRIP* dwg_object_to_BLOCKLOOKUPGRIP (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKLOOKUPPARAMETER* dwg_object_to_BLOCKLOOKUPPARAMETER (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKMOVEACTION* dwg_object_to_BLOCKMOVEACTION (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKPARAMDEPENDENCYBODY* dwg_object_to_BLOCKPARAMDEPENDENCYBODY (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKPOINTPARAMETER* dwg_object_to_BLOCKPOINTPARAMETER (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKPOLARGRIP* dwg_object_to_BLOCKPOLARGRIP (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKPOLARPARAMETER* dwg_object_to_BLOCKPOLARPARAMETER (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKPOLARSTRETCHACTION* dwg_object_to_BLOCKPOLARSTRETCHACTION (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKPROPERTIESTABLE* dwg_object_to_BLOCKPROPERTIESTABLE (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKPROPERTIESTABLEGRIP* dwg_object_to_BLOCKPROPERTIESTABLEGRIP (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKRADIALCONSTRAINTPARAMETER* dwg_object_to_BLOCKRADIALCONSTRAINTPARAMETER (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKREPRESENTATION* dwg_object_to_BLOCKREPRESENTATION (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKROTATEACTION* dwg_object_to_BLOCKROTATEACTION (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKROTATIONGRIP* dwg_object_to_BLOCKROTATIONGRIP (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKROTATIONPARAMETER* dwg_object_to_BLOCKROTATIONPARAMETER (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKSCALEACTION* dwg_object_to_BLOCKSCALEACTION (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKSTRETCHACTION* dwg_object_to_BLOCKSTRETCHACTION (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKUSERPARAMETER* dwg_object_to_BLOCKUSERPARAMETER (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKVERTICALCONSTRAINTPARAMETER* dwg_object_to_BLOCKVERTICALCONSTRAINTPARAMETER (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKVISIBILITYPARAMETER* dwg_object_to_BLOCKVISIBILITYPARAMETER (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKXYGRIP* dwg_object_to_BLOCKXYGRIP (Dwg_Object* obj);
  EXPORT Dwg_Object_BLOCKXYPARAMETER* dwg_object_to_BLOCKXYPARAMETER (Dwg_Object* obj);
  EXPORT Dwg_Object_CONTEXTDATAMANAGER* dwg_object_to_CONTEXTDATAMANAGER (Dwg_Object* obj);
  EXPORT Dwg_Object_CSACDOCUMENTOPTIONS* dwg_object_to_CSACDOCUMENTOPTIONS (Dwg_Object* obj);
  EXPORT Dwg_Object_CURVEPATH* dwg_object_to_CURVEPATH (Dwg_Object* obj);
  EXPORT Dwg_Object_DATALINK* dwg_object_to_DATALINK (Dwg_Object* obj);
  EXPORT Dwg_Object_DATATABLE* dwg_object_to_DATATABLE (Dwg_Object* obj);
  EXPORT Dwg_Object_DMDIMOBJECTCONTEXTDATA* dwg_object_to_DMDIMOBJECTCONTEXTDATA (Dwg_Object* obj);
  EXPORT Dwg_Object_DYNAMICBLOCKPROXYNODE* dwg_object_to_DYNAMICBLOCKPROXYNODE (Dwg_Object* obj);
  EXPORT Dwg_Object_EVALUATION_GRAPH* dwg_object_to_EVALUATION_GRAPH (Dwg_Object* obj);
  EXPORT Dwg_Object_FCFOBJECTCONTEXTDATA* dwg_object_to_FCFOBJECTCONTEXTDATA (Dwg_Object* obj);
  EXPORT Dwg_Object_GEOMAPIMAGE* dwg_object_to_GEOMAPIMAGE (Dwg_Object* obj);
  EXPORT Dwg_Object_LAYOUTPRINTCONFIG* dwg_object_to_LAYOUTPRINTCONFIG (Dwg_Object* obj);
  EXPORT Dwg_Object_LEADEROBJECTCONTEXTDATA* dwg_object_to_LEADEROBJECTCONTEXTDATA (Dwg_Object* obj);
  EXPORT Dwg_Object_MLEADEROBJECTCONTEXTDATA* dwg_object_to_MLEADEROBJECTCONTEXTDATA (Dwg_Object* obj);
  EXPORT Dwg_Object_MOTIONPATH* dwg_object_to_MOTIONPATH (Dwg_Object* obj);
  EXPORT Dwg_Object_MTEXTATTRIBUTEOBJECTCONTEXTDATA* dwg_object_to_MTEXTATTRIBUTEOBJECTCONTEXTDATA (Dwg_Object* obj);
  EXPORT Dwg_Object_MTEXTOBJECTCONTEXTDATA* dwg_object_to_MTEXTOBJECTCONTEXTDATA (Dwg_Object* obj);
  EXPORT Dwg_Object_NAVISWORKSMODELDEF* dwg_object_to_NAVISWORKSMODELDEF (Dwg_Object* obj);
  EXPORT Dwg_Object_OBJECTCONTEXTDATA* dwg_object_to_OBJECTCONTEXTDATA (Dwg_Object* obj);
  EXPORT Dwg_Object_ORDDIMOBJECTCONTEXTDATA* dwg_object_to_ORDDIMOBJECTCONTEXTDATA (Dwg_Object* obj);
  EXPORT Dwg_Object_PERSUBENTMGR* dwg_object_to_PERSUBENTMGR (Dwg_Object* obj);
  EXPORT Dwg_Object_POINTPATH* dwg_object_to_POINTPATH (Dwg_Object* obj);
  EXPORT Dwg_Object_RADIMLGOBJECTCONTEXTDATA* dwg_object_to_RADIMLGOBJECTCONTEXTDATA (Dwg_Object* obj);
  EXPORT Dwg_Object_RADIMOBJECTCONTEXTDATA* dwg_object_to_RADIMOBJECTCONTEXTDATA (Dwg_Object* obj);
  EXPORT Dwg_Object_RENDERENTRY* dwg_object_to_RENDERENTRY (Dwg_Object* obj);
  EXPORT Dwg_Object_RENDERENVIRONMENT* dwg_object_to_RENDERENVIRONMENT (Dwg_Object* obj);
  EXPORT Dwg_Object_RENDERGLOBAL* dwg_object_to_RENDERGLOBAL (Dwg_Object* obj);
  EXPORT Dwg_Object_SUNSTUDY* dwg_object_to_SUNSTUDY (Dwg_Object* obj);
  EXPORT Dwg_Object_TABLECONTENT* dwg_object_to_TABLECONTENT (Dwg_Object* obj);
  EXPORT Dwg_Object_TEXTOBJECTCONTEXTDATA* dwg_object_to_TEXTOBJECTCONTEXTDATA (Dwg_Object* obj);
  EXPORT Dwg_Object_TVDEVICEPROPERTIES* dwg_object_to_TVDEVICEPROPERTIES (Dwg_Object* obj);
#endif
/* End auto-generated content */
