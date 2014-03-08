package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.berilia.managers.SecureCenter;
   import flash.display.DisplayObject;
   import flash.utils.ByteArray;
   import mx.graphics.codec.JPEGEncoder;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import flash.filesystem.File;
   import mx.graphics.codec.PNGEncoder;
   import flash.geom.Matrix;
   
   public class CaptureApi extends Object implements IApi
   {
      
      public function CaptureApi() {
         super();
      }
      
      public static function getScreen(param1:Rectangle=null, param2:Number=1.0) : BitmapData {
         return capture(StageShareManager.stage,param1,new Rectangle(0,0,StageShareManager.startWidth,StageShareManager.startHeight),param2);
      }
      
      public static function getBattleField(param1:Rectangle=null, param2:Number=1.0) : BitmapData {
         return capture(Atouin.getInstance().worldContainer,param1,new Rectangle(0,0,AtouinConstants.CELL_WIDTH * AtouinConstants.MAP_WIDTH,AtouinConstants.CELL_HEIGHT * AtouinConstants.MAP_HEIGHT),param2);
      }
      
      public static function getFromTarget(param1:Object, param2:Rectangle=null, param3:Number=1.0, param4:Boolean=false) : BitmapData {
         var param1:Object = SecureCenter.unsecure(param1);
         if(!param1 || !(param1 is DisplayObject))
         {
            return null;
         }
         var _loc5_:* = param1 as DisplayObject;
         var _loc6_:Rectangle = _loc5_.getBounds(_loc5_);
         if(!_loc6_.width || !_loc6_.height)
         {
            return null;
         }
         return capture(_loc5_,param2,_loc6_,param3,param4);
      }
      
      public static function jpegEncode(param1:BitmapData, param2:uint=80, param3:Boolean=true, param4:String="image.jpg") : ByteArray {
         var _loc5_:ByteArray = new JPEGEncoder(param2).encode(param1);
         if((param3) && (AirScanner.hasAir()))
         {
            File.desktopDirectory.save(_loc5_,param4);
         }
         return _loc5_;
      }
      
      public static function pngEncode(param1:BitmapData, param2:Boolean=true, param3:String="image.png") : ByteArray {
         var _loc4_:ByteArray = new PNGEncoder().encode(param1);
         if((param2) && (AirScanner.hasAir()))
         {
            File.desktopDirectory.save(_loc4_,param3);
         }
         return _loc4_;
      }
      
      private static function capture(param1:DisplayObject, param2:Rectangle, param3:Rectangle, param4:Number=1.0, param5:Boolean=false) : BitmapData {
         var _loc6_:Rectangle = null;
         var _loc7_:Matrix = null;
         var _loc8_:BitmapData = null;
         if(!param2)
         {
            _loc6_ = param3;
         }
         else
         {
            _loc6_ = param3.intersection(param2);
         }
         if(param1)
         {
            _loc7_ = new Matrix();
            _loc7_.scale(param4,param4);
            _loc7_.translate(-_loc6_.x * param4,-_loc6_.y * param4);
            _loc8_ = new BitmapData(_loc6_.width * param4,_loc6_.height * param4,param5,param5?16711680:4.294967295E9);
            _loc8_.draw(param1,_loc7_);
            return _loc8_;
         }
         return null;
      }
   }
}
