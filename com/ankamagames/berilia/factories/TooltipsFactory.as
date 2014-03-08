package com.ankamagames.berilia.factories
{
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   import com.ankamagames.berilia.managers.SecureCenter;
   import com.ankamagames.berilia.types.tooltip.EmptyTooltip;
   import com.ankamagames.berilia.managers.TooltipManager;
   
   public class TooltipsFactory extends Object
   {
      
      public function TooltipsFactory() {
         super();
      }
      
      private static var _registeredMaker:Array = new Array();
      
      private static var _makerAssoc:Array = new Array();
      
      public static function registerMaker(param1:String, param2:Class, param3:Class=null) : void {
         _registeredMaker[param1] = new TooltipData(param2,param3);
      }
      
      public static function registerAssoc(param1:*, param2:String) : void {
         _makerAssoc[getQualifiedClassName(param1)] = param2;
      }
      
      public static function existRegisterMaker(param1:String) : Boolean {
         return _registeredMaker[param1]?true:false;
      }
      
      public static function existMakerAssoc(param1:*) : Boolean {
         return _makerAssoc[getQualifiedClassName(param1)]?true:false;
      }
      
      public static function unregister(param1:Class, param2:Class) : void {
         if(TooltipData(_registeredMaker[getQualifiedClassName(param1)]).maker === param2)
         {
            delete _registeredMaker[[getQualifiedClassName(param1)]];
         }
      }
      
      public static function create(param1:*, param2:String=null, param3:Class=null, param4:Object=null) : Tooltip {
         var _loc6_:* = undefined;
         var _loc7_:Tooltip = null;
         var _loc8_:Object = null;
         if(!param2)
         {
            param2 = _makerAssoc[getQualifiedClassName(param1)];
         }
         var _loc5_:TooltipData = _registeredMaker[param2];
         if(_loc5_)
         {
            _loc6_ = new _loc5_.maker();
            _loc8_ = _loc6_.createTooltip(SecureCenter.secure(param1),param4);
            if(_loc8_ == "")
            {
               _loc7_ = new EmptyTooltip();
               return _loc7_;
            }
            _loc7_ = _loc8_ as Tooltip;
            if(_loc7_ == null)
            {
               return null;
            }
            if(TooltipManager.defaultTooltipUiScript == param3)
            {
               _loc7_.scriptClass = _loc5_.scriptClass?_loc5_.scriptClass:param3;
            }
            else
            {
               _loc7_.scriptClass = param3;
            }
            _loc7_.makerName = param2;
            return _loc7_;
         }
         return null;
      }
   }
}
class TooltipData extends Object
{
   
   function TooltipData(param1:Class, param2:Class) {
      super();
      this.maker = param1;
      this.scriptClass = param2;
   }
   
   public var maker:Class;
   
   public var scriptClass:Class;
}
