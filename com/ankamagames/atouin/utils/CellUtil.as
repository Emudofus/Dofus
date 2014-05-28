package com.ankamagames.atouin.utils
{
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import flash.display.Sprite;
   
   public class CellUtil extends Object
   {
      
      public function CellUtil() {
         super();
      }
      
      public static function getPixelXFromMapPoint(p:MapPoint) : int {
         var cellSprite:Sprite = InteractiveCellManager.getInstance().getCell(p.cellId);
         return cellSprite.x + cellSprite.width / 2;
      }
      
      public static function getPixelYFromMapPoint(p:MapPoint) : int {
         var cellSprite:Sprite = InteractiveCellManager.getInstance().getCell(p.cellId);
         return cellSprite.y + cellSprite.height / 2;
      }
      
      public static function isLeftCol(cellId:int) : Boolean {
         return cellId % 14 == 0;
      }
      
      public static function isRightCol(cellId:int) : Boolean {
         return isLeftCol(cellId + 1);
      }
      
      public static function isTopRow(cellId:int) : Boolean {
         return cellId < 28;
      }
      
      public static function isBottomRow(cellId:int) : Boolean {
         return cellId > 531;
      }
      
      public static function isEvenRow(cellId:int) : Boolean {
         return Math.floor(cellId / 14) % 2 == 0;
      }
   }
}
