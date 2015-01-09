package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import flash.geom.Rectangle;
    import flash.display.BitmapData;
    import com.ankamagames.atouin.Atouin;
    import com.ankamagames.atouin.AtouinConstants;
    import com.ankamagames.berilia.managers.SecureCenter;
    import flash.display.DisplayObject;
    import mx.graphics.codec.JPEGEncoder;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.utils.system.AirScanner;
    import flash.filesystem.File;
    import mx.graphics.codec.PNGEncoder;
    import flash.geom.Matrix;

    public class CaptureApi implements IApi 
    {


        [Untrusted]
        [NoBoxing]
        [NoReplaceInFakeClass]
        public static function getScreen(rect:Rectangle=null, scale:Number=1):BitmapData
        {
            return (capture(StageShareManager.stage, rect, new Rectangle(0, 0, StageShareManager.startWidth, StageShareManager.startHeight), scale));
        }

        [Untrusted]
        [NoBoxing]
        [NoReplaceInFakeClass]
        public static function getBattleField(rect:Rectangle=null, scale:Number=1):BitmapData
        {
            return (capture(Atouin.getInstance().worldContainer, rect, new Rectangle(0, 0, (AtouinConstants.CELL_WIDTH * AtouinConstants.MAP_WIDTH), (AtouinConstants.CELL_HEIGHT * AtouinConstants.MAP_HEIGHT)), scale));
        }

        [Untrusted]
        [NoBoxing]
        [NoReplaceInFakeClass]
        public static function getFromTarget(target:Object, rect:Rectangle=null, scale:Number=1, transparent:Boolean=false):BitmapData
        {
            target = SecureCenter.unsecure(target);
            if (((!(target)) || (!((target is DisplayObject)))))
            {
                return (null);
            };
            var dObj:DisplayObject = (target as DisplayObject);
            var bounds:Rectangle = dObj.getBounds(dObj);
            if (((!(bounds.width)) || (!(bounds.height))))
            {
                return (null);
            };
            return (capture(dObj, rect, bounds, scale, transparent));
        }

        [Untrusted]
        [NoBoxing]
        [NoReplaceInFakeClass]
        public static function jpegEncode(img:BitmapData, quality:uint=80, askForSave:Boolean=true, fileName:String="image.jpg"):ByteArray
        {
            var encodedImg:ByteArray = new JPEGEncoder(quality).encode(img);
            if (((askForSave) && (AirScanner.hasAir())))
            {
                File.desktopDirectory.save(encodedImg, fileName);
            };
            return (encodedImg);
        }

        [Untrusted]
        [NoBoxing]
        [NoReplaceInFakeClass]
        public static function pngEncode(img:BitmapData, askForSave:Boolean=true, fileName:String="image.png"):ByteArray
        {
            var encodedImg:ByteArray = new PNGEncoder().encode(img);
            if (((askForSave) && (AirScanner.hasAir())))
            {
                File.desktopDirectory.save(encodedImg, fileName);
            };
            return (encodedImg);
        }

        private static function capture(target:DisplayObject, rect:Rectangle, maxRect:Rectangle, scale:Number=1, transparent:Boolean=false):BitmapData
        {
            var rect2:Rectangle;
            var matrix:Matrix;
            var data:BitmapData;
            if (!(rect))
            {
                rect2 = maxRect;
            }
            else
            {
                rect2 = maxRect.intersection(rect);
            };
            if (target)
            {
                matrix = new Matrix();
                matrix.scale(scale, scale);
                matrix.translate((-(rect2.x) * scale), (-(rect2.y) * scale));
                data = new BitmapData((rect2.width * scale), (rect2.height * scale), transparent, ((transparent) ? 0xFF0000 : 0xFFFFFFFF));
                data.draw(target, matrix);
                return (data);
            };
            return (null);
        }


    }
}//package com.ankamagames.dofus.uiApi

