package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.jerakine.utils.misc.CallWithParameters;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.misc.utils.ParamsDecoder;
   import flash.geom.ColorTransform;


   public class UtilApi extends Object implements IApi
   {
         

      public function UtilApi() {
         super();
      }



      private var _module:UiModule;

      public function set module(value:UiModule) : void {
         this._module=value;
      }

      public function destroy() : void {
         this._module=null;
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
         if(obj!=null)
         {
            if(unColor)
            {
               t0=new ColorTransform(1,1,1,1,0,0,0);
               obj.colorTransform(t0,depth);
            }
            else
            {
               R=color>>16&255;
               V=color>>8&255;
               B=color>>0&255;
               t=new ColorTransform(0,0,0,1,R,V,B);
               obj.colorTransform(t,depth);
            }
         }
      }
   }

}