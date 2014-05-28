package com.ankamagames.dofus.misc.utils
{
   import flash.utils.Dictionary;
   import flash.geom.Matrix;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   
   public class EmbedAssets extends Object
   {
      
      public function EmbedAssets() {
         super();
      }
      
      private static var _cache:Dictionary;
      
      public static const DefaultBeriliaSlotIcon:Class;
      
      public static const CHECKPOINT_CLIP_TOP:Class;
      
      public static const CHECKPOINT_CLIP_LEFT:Class;
      
      public static const CHECKPOINT_CLIP_BOTTOM:Class;
      
      public static const CHECKPOINT_CLIP_RIGHT:Class;
      
      private static const CHECKPOINT_CLIP:Class;
      
      private static const QUEST_CLIP:Class;
      
      private static const QUEST_REPEATABLE_CLIP:Class;
      
      private static const QUEST_OBJECTIVE_CLIP:Class;
      
      private static const QUEST_REPEATABLE_OBJECTIVE_CLIP:Class;
      
      private static const TEAM_CIRCLE_CLIP:Class;
      
      private static const SWORDS_CLIP:Class;
      
      private static const FLAG_CURSOR:Class;
      
      private static var matrix:Matrix;
      
      public static function getBitmap(className:String, unique:Boolean = false, useCache:Boolean = true) : Bitmap {
         var bmp:Bitmap = null;
         var bmpdt:BitmapData = null;
         if((useCache) && (!(_cache[className] == null)))
         {
            bmp = _cache[className];
            if(!unique)
            {
               return bmp;
            }
            bmpdt = new BitmapData(bmp.width,bmp.height,true,16711935);
            bmpdt.draw(bmp,matrix);
            return new Bitmap(bmpdt);
         }
         var ClassReference:Class = EmbedAssets[className] as Class;
         bmp = new ClassReference() as Bitmap;
         if(useCache)
         {
            saveCache(className,bmp);
         }
         return bmp;
      }
      
      public static function getSprite(className:String) : Sprite {
         var ClassReference:Class = EmbedAssets[className] as Class;
         var spr:Sprite = new ClassReference() as Sprite;
         return spr;
      }
      
      public static function getClass(className:String) : Class {
         return EmbedAssets[className] as Class;
      }
      
      private static function saveCache(className:String, data:*) : void {
         _cache[className] = data;
      }
   }
}
