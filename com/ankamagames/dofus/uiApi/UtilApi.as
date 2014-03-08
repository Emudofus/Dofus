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
   import __AS3__.vec.*;
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
      
      public function set module(value:UiModule) : void {
         this._module = value;
      }
      
      public function destroy() : void {
         this._module = null;
      }
      
      public function callWithParameters(method:Function, parameters:Array) : void {
         CallWithParameters.call(method,parameters);
      }
      
      public function callConstructorWithParameters(callClass:Class, parameters:Array) : * {
         return CallWithParameters.callConstructor(callClass,parameters);
      }
      
      public function callRWithParameters(method:Function, parameters:Array) : * {
         return CallWithParameters.callR(method,parameters);
      }
      
      public function kamasToString(kamas:Number, unit:String="-") : String {
         return StringUtils.kamasToString(kamas,unit);
      }
      
      public function formateIntToString(val:Number) : String {
         return StringUtils.formateIntToString(val);
      }
      
      public function stringToKamas(string:String, unit:String="-") : int {
         return StringUtils.stringToKamas(string,unit);
      }
      
      public function getTextWithParams(textId:int, params:Array, replace:String="%") : String {
         var msgContent:String = I18n.getText(textId);
         if(msgContent)
         {
            return ParamsDecoder.applyParams(msgContent,params,replace);
         }
         return "";
      }
      
      public function applyTextParams(pText:String, pParams:Array, pReplace:String="%") : String {
         return ParamsDecoder.applyParams(pText,pParams,pReplace);
      }
      
      public function noAccent(str:String) : String {
         return StringUtils.noAccent(str);
      }
      
      public function changeColor(obj:Object, color:Number, depth:int, unColor:Boolean=false) : void {
         var t0:ColorTransform = null;
         var R:* = 0;
         var V:* = 0;
         var B:* = 0;
         var t:ColorTransform = null;
         if(obj != null)
         {
            if(unColor)
            {
               t0 = new ColorTransform(1,1,1,1,0,0,0);
               if(obj is Texture)
               {
                  Texture(obj).colorTransform(t0,depth);
               }
               else
               {
                  if(obj is DisplayObject)
                  {
                     DisplayObject(obj).transform.colorTransform = t0;
                  }
               }
            }
            else
            {
               R = color >> 16 & 255;
               V = color >> 8 & 255;
               B = color >> 0 & 255;
               t = new ColorTransform(0,0,0,1,R,V,B);
               if(obj is Texture)
               {
                  Texture(obj).colorTransform(t,depth);
               }
               else
               {
                  if(obj is DisplayObject)
                  {
                     DisplayObject(obj).transform.colorTransform = t;
                  }
               }
            }
         }
      }
      
      public function sortOnString(list:*, field:String="") : void {
         if((!(list is Array)) && (!(list is Vector.<*>)))
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
            list.sort(function(a:*, b:*):int
            {
               return _stringSorter.compare(a[field],b[field]);
            });
         }
         else
         {
            list.sort(this._stringSorter.compare);
         }
      }
      
      public function sort(target:*, field:String, ascendand:Boolean=true, isNumeric:Boolean=false) : * {
         var result:* = undefined;
         var sup:int = 0;
         var inf:int = 0;
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
               result.sort(function(a:*, b:*):int
               {
                  if(a[field] > b[field])
                  {
                     return sup;
                  }
                  if(a[field] < b[field])
                  {
                     return inf;
                  }
                  return 0;
               });
            }
            else
            {
               result.sort(function(a:*, b:*):int
               {
                  var astr:String = a[field].toLocaleLowerCase();
                  var bstr:String = b[field].toLocaleLowerCase();
                  if(astr > bstr)
                  {
                     return sup;
                  }
                  if(astr < bstr)
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
      
      public function filter(target:*, pattern:*, field:String) : * {
         var searchFor:String = null;
         if(!target)
         {
            return null;
         }
         var result:* = new target.constructor as Class();
         var len:uint = target.length;
         var i:uint = 0;
         if(pattern is String)
         {
            searchFor = String(pattern).toLowerCase();
            while(i < len)
            {
               if(String(target[i][field]).toLowerCase().indexOf(searchFor) != -1)
               {
                  result.push(target[i]);
               }
               i++;
            }
         }
         else
         {
            while(i < len)
            {
               if(target[i][field] == pattern)
               {
                  result.push(target[i]);
               }
               i++;
            }
         }
         return result;
      }
      
      public function getTiphonEntityLook(pEntityId:int) : TiphonEntityLook {
         return EntitiesLooksManager.getInstance().getTiphonEntityLook(pEntityId);
      }
      
      public function getRealTiphonEntityLook(pEntityId:int, pWithoutMount:Boolean=false) : TiphonEntityLook {
         return EntitiesLooksManager.getInstance().getRealTiphonEntityLook(pEntityId,pWithoutMount);
      }
      
      public function getLookFromContext(pEntityId:int, pForceCreature:Boolean=false) : TiphonEntityLook {
         return EntitiesLooksManager.getInstance().getLookFromContext(pEntityId,pForceCreature);
      }
      
      public function getLookFromContextInfos(pInfos:GameContextActorInformations, pForceCreature:Boolean=false) : TiphonEntityLook {
         return EntitiesLooksManager.getInstance().getLookFromContextInfos(pInfos,pForceCreature);
      }
      
      public function isCreature(pEntityId:int) : Boolean {
         return EntitiesLooksManager.getInstance().isCreature(pEntityId);
      }
      
      public function isCreatureFromLook(pLook:TiphonEntityLook) : Boolean {
         return EntitiesLooksManager.getInstance().isCreatureFromLook(pLook);
      }
      
      public function isIncarnation(pEntityId:int) : Boolean {
         return EntitiesLooksManager.getInstance().isIncarnation(pEntityId);
      }
      
      public function isIncarnationFromLook(pLook:TiphonEntityLook) : Boolean {
         return EntitiesLooksManager.getInstance().isIncarnationFromLook(pLook);
      }
      
      public function isCreatureMode() : Boolean {
         return EntitiesLooksManager.getInstance().isCreatureMode();
      }
      
      public function getCreatureLook(pEntityId:int) : TiphonEntityLook {
         return EntitiesLooksManager.getInstance().getCreatureLook(pEntityId);
      }
   }
}
