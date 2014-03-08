package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.berilia.types.data.UiModule;
   import flash.globalization.Collator;
   import com.ankamagames.jerakine.utils.misc.CallWithParameters;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.misc.utils.ParamsDecoder;
   import flash.geom.ColorTransform;
   import com.ankamagames.berilia.components.Texture;
   import flash.display.DisplayObject;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.dofus.logic.game.common.managers.EntitiesLooksManager;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class UtilApi extends Object implements IApi
   {
      
      public function UtilApi() {
         this._log = Log.getLogger(getQualifiedClassName(UtilApi));
         super();
      }
      
      protected var _log:Logger;
      
      private var _module:UiModule;
      
      private var _stringSorter:Collator;
      
      public function set module(param1:UiModule) : void {
         this._module = param1;
      }
      
      public function destroy() : void {
         this._module = null;
      }
      
      public function callWithParameters(param1:Function, param2:Array) : void {
         CallWithParameters.call(param1,param2);
      }
      
      public function callConstructorWithParameters(param1:Class, param2:Array) : * {
         return CallWithParameters.callConstructor(param1,param2);
      }
      
      public function callRWithParameters(param1:Function, param2:Array) : * {
         return CallWithParameters.callR(param1,param2);
      }
      
      public function kamasToString(param1:Number, param2:String="-") : String {
         return StringUtils.kamasToString(param1,param2);
      }
      
      public function formateIntToString(param1:Number) : String {
         return StringUtils.formateIntToString(param1);
      }
      
      public function stringToKamas(param1:String, param2:String="-") : int {
         return StringUtils.stringToKamas(param1,param2);
      }
      
      public function getTextWithParams(param1:int, param2:Array, param3:String="%") : String {
         var _loc4_:String = I18n.getText(param1);
         if(_loc4_)
         {
            return ParamsDecoder.applyParams(_loc4_,param2,param3);
         }
         return "";
      }
      
      public function applyTextParams(param1:String, param2:Array, param3:String="%") : String {
         return ParamsDecoder.applyParams(param1,param2,param3);
      }
      
      public function noAccent(param1:String) : String {
         return StringUtils.noAccent(param1);
      }
      
      public function changeColor(param1:Object, param2:Number, param3:int, param4:Boolean=false) : void {
         var _loc5_:ColorTransform = null;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:ColorTransform = null;
         if(param1 != null)
         {
            if(param4)
            {
               _loc5_ = new ColorTransform(1,1,1,1,0,0,0);
               if(param1 is Texture)
               {
                  Texture(param1).colorTransform(_loc5_,param3);
               }
               else
               {
                  if(param1 is DisplayObject)
                  {
                     DisplayObject(param1).transform.colorTransform = _loc5_;
                  }
               }
            }
            else
            {
               _loc6_ = param2 >> 16 & 255;
               _loc7_ = param2 >> 8 & 255;
               _loc8_ = param2 >> 0 & 255;
               _loc9_ = new ColorTransform(0,0,0,1,_loc6_,_loc7_,_loc8_);
               if(param1 is Texture)
               {
                  Texture(param1).colorTransform(_loc9_,param3);
               }
               else
               {
                  if(param1 is DisplayObject)
                  {
                     DisplayObject(param1).transform.colorTransform = _loc9_;
                  }
               }
            }
         }
      }
      
      public function sortOnString(param1:*, param2:String="") : void {
         var list:* = param1;
         var field:String = param2;
         if(!(list is Array) && !(list is Vector.<*>))
         {
            this._log.error("Tried to sort something different than an Array or a Vector!");
            return;
         }
         if(!this._stringSorter)
         {
            this._stringSorter = new Collator(XmlConfig.getInstance().getEntry("config.lang.current"));
         }
         if(field)
         {
            list.sort(function(param1:*, param2:*):int
            {
               return _stringSorter.compare(param1[field],param2[field]);
            });
         }
         else
         {
            list.sort(this._stringSorter.compare);
         }
      }
      
      public function sort(param1:*, param2:String, param3:Boolean=true, param4:Boolean=false) : * {
         var result:* = undefined;
         var sup:int = 0;
         var inf:int = 0;
         var target:* = param1;
         var field:String = param2;
         var ascendand:Boolean = param3;
         var isNumeric:Boolean = param4;
         if(target is Array)
         {
            result = (target as Array).concat();
            result.sortOn(field,(ascendand?0:Array.DESCENDING) | (isNumeric?Array.NUMERIC:Array.CASEINSENSITIVE));
            return result;
         }
         if(target is Vector.<*>)
         {
            result = target.concat();
            sup = ascendand?1:-1;
            inf = ascendand?-1:1;
            if(isNumeric)
            {
               result.sort(function(param1:*, param2:*):int
               {
                  if(param1[field] > param2[field])
                  {
                     return sup;
                  }
                  if(param1[field] < param2[field])
                  {
                     return inf;
                  }
                  return 0;
               });
            }
            else
            {
               result.sort(function(param1:*, param2:*):int
               {
                  var _loc3_:String = param1[field].toLocaleLowerCase();
                  var _loc4_:String = param2[field].toLocaleLowerCase();
                  if(_loc3_ > _loc4_)
                  {
                     return sup;
                  }
                  if(_loc3_ < _loc4_)
                  {
                     return inf;
                  }
                  return 0;
               });
            }
            return result;
         }
         return null;
      }
      
      public function filter(param1:*, param2:*, param3:String) : * {
         var _loc7_:String = null;
         if(!param1)
         {
            return null;
         }
         var _loc4_:* = new param1.constructor as Class();
         var _loc5_:uint = param1.length;
         var _loc6_:uint = 0;
         if(param2 is String)
         {
            _loc7_ = String(param2).toLowerCase();
            while(_loc6_ < _loc5_)
            {
               if(String(param1[_loc6_][param3]).toLowerCase().indexOf(_loc7_) != -1)
               {
                  _loc4_.push(param1[_loc6_]);
               }
               _loc6_++;
            }
         }
         else
         {
            while(_loc6_ < _loc5_)
            {
               if(param1[_loc6_][param3] == param2)
               {
                  _loc4_.push(param1[_loc6_]);
               }
               _loc6_++;
            }
         }
         return _loc4_;
      }
      
      public function getTiphonEntityLook(param1:int) : TiphonEntityLook {
         return EntitiesLooksManager.getInstance().getTiphonEntityLook(param1);
      }
      
      public function getRealTiphonEntityLook(param1:int, param2:Boolean=false) : TiphonEntityLook {
         return EntitiesLooksManager.getInstance().getRealTiphonEntityLook(param1,param2);
      }
      
      public function getLookFromContext(param1:int, param2:Boolean=false) : TiphonEntityLook {
         return EntitiesLooksManager.getInstance().getLookFromContext(param1,param2);
      }
      
      public function getLookFromContextInfos(param1:GameContextActorInformations, param2:Boolean=false) : TiphonEntityLook {
         return EntitiesLooksManager.getInstance().getLookFromContextInfos(param1,param2);
      }
      
      public function isCreature(param1:int) : Boolean {
         return EntitiesLooksManager.getInstance().isCreature(param1);
      }
      
      public function isCreatureFromLook(param1:TiphonEntityLook) : Boolean {
         return EntitiesLooksManager.getInstance().isCreatureFromLook(param1);
      }
      
      public function isIncarnation(param1:int) : Boolean {
         return EntitiesLooksManager.getInstance().isIncarnation(param1);
      }
      
      public function isIncarnationFromLook(param1:TiphonEntityLook) : Boolean {
         return EntitiesLooksManager.getInstance().isIncarnationFromLook(param1);
      }
      
      public function isCreatureMode() : Boolean {
         return EntitiesLooksManager.getInstance().isCreatureMode();
      }
      
      public function getCreatureLook(param1:int) : TiphonEntityLook {
         return EntitiesLooksManager.getInstance().getCreatureLook(param1);
      }
   }
}
