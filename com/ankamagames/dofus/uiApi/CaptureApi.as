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
      
      public static function getScreen(rect:Rectangle = null, scale:Number = 1.0) : BitmapData {
         return capture(StageShareManager.stage,rect,new Rectangle(0,0,StageShareManager.startWidth,StageShareManager.startHeight),scale);
      }
      
      public static function getBattleField(rect:Rectangle = null, scale:Number = 1.0) : BitmapData {
         return capture(Atouin.getInstance().worldContainer,rect,new Rectangle(0,0,AtouinConstants.CELL_WIDTH * AtouinConstants.MAP_WIDTH,AtouinConstants.CELL_HEIGHT * AtouinConstants.MAP_HEIGHT),scale);
      }
      
      public static function getFromTarget(target:Object, rect:Rectangle = null, scale:Number = 1.0, transparent:Boolean = false) : BitmapData {
         var target:Object = SecureCenter.unsecure(target);
         if((!target) || (!(target is DisplayObject)))
         {
            return null;
         }
         var dObj:DisplayObject = target as DisplayObject;
         var bounds:Rectangle = dObj.getBounds(dObj);
         if((!bounds.width) || (!bounds.height))
         {
            return null;
         }
         return capture(dObj,rect,bounds,scale,transparent);
      }
      
      public static function jpegEncode(img:BitmapData, quality:uint = 80, askForSave:Boolean = true, fileName:String = "image.jpg") : ByteArray {
         var encodedImg:ByteArray = new JPEGEncoder(quality).encode(img);
         if((askForSave) && (AirScanner.hasAir()))
         {
            File.desktopDirectory.save(encodedImg,fileName);
         }
         return encodedImg;
      }
      
      public static function pngEncode(img:BitmapData, askForSave:Boolean = true, fileName:String = "image.png") : ByteArray {
         var encodedImg:ByteArray = new PNGEncoder().encode(img);
         if((askForSave) && (AirScanner.hasAir()))
         {
            File.desktopDirectory.save(encodedImg,fileName);
         }
         return encodedImg;
      }
      
      private static function capture(target:DisplayObject, rect:Rectangle, maxRect:Rectangle, scale:Number = 1.0, transparent:Boolean = false) : BitmapData {
         var rect2:Rectangle = null;
         var matrix:Matrix = null;
         var data:BitmapData = null;
         if(!rect)
         {
            rect2 = maxRect;
         }
         else
         {
            rect2 = maxRect.intersection(rect);
         }
         if(target)
         {
            matrix = new Matrix();
            matrix.scale(scale,scale);
            matrix.translate(-rect2.x * scale,-rect2.y * scale);
            data = new BitmapData(rect2.width * scale,rect2.height * scale,transparent,transparent?16711680:4.294967295E9);
            data.draw(target,matrix);
            return data;
         }
         return null;
      }
   }
}
