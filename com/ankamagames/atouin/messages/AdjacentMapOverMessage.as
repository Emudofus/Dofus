package com.ankamagames.atouin.messages
{
   import com.ankamagames.jerakine.messages.Message;
   import flash.display.DisplayObject;
   import com.ankamagames.atouin.data.map.CellData;
   
   public class AdjacentMapOverMessage extends Object implements Message
   {
      
      public function AdjacentMapOverMessage(param1:uint, param2:DisplayObject, param3:int, param4:CellData) {
         super();
         this._nDirection = param1;
         this._spZone = param2;
         this._cellId = param3;
         this._cellData = param4;
      }
      
      private var _nDirection:uint;
      
      private var _spZone:DisplayObject;
      
      private var _cellId:int;
      
      private var _cellData:CellData;
      
      public function get direction() : uint {
         return this._nDirection;
      }
      
      public function get zone() : DisplayObject {
         return this._spZone;
      }
      
      public function get cellId() : int {
         return this._cellId;
      }
      
      public function get cellData() : CellData {
         return this._cellData;
      }
   }
}
