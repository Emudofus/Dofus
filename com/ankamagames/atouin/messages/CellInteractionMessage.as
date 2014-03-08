package com.ankamagames.atouin.messages
{
   import flash.display.Sprite;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public class CellInteractionMessage extends MapMessage
   {
      
      public function CellInteractionMessage() {
         super();
      }
      
      private var _cellId:uint;
      
      private var _cellDepth:uint;
      
      private var _cellContainer:Sprite;
      
      private var _cellCoords:MapPoint;
      
      public function get cellId() : uint {
         return this._cellId;
      }
      
      public function set cellId(param1:uint) : void {
         this._cellId = param1;
      }
      
      public function get cellContainer() : Sprite {
         return this._cellContainer;
      }
      
      public function set cellContainer(param1:Sprite) : void {
         this._cellContainer = param1;
      }
      
      public function get cellDepth() : uint {
         return this._cellDepth;
      }
      
      public function set cellDepth(param1:uint) : void {
         this._cellDepth = param1;
      }
      
      public function get cell() : MapPoint {
         return this._cellCoords;
      }
      
      public function set cell(param1:MapPoint) : void {
         this._cellCoords = param1;
      }
   }
}
