package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameFightTurnListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightTurnListMessage() {
         this.ids = new Vector.<int>();
         this.deadsIds = new Vector.<int>();
         super();
      }
      
      public static const protocolId:uint = 713;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var ids:Vector.<int>;
      
      public var deadsIds:Vector.<int>;
      
      override public function getMessageId() : uint {
         return 713;
      }
      
      public function initGameFightTurnListMessage(ids:Vector.<int>=null, deadsIds:Vector.<int>=null) : GameFightTurnListMessage {
         this.ids = ids;
         this.deadsIds = deadsIds;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.ids = new Vector.<int>();
         this.deadsIds = new Vector.<int>();
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameFightTurnListMessage(output);
      }
      
      public function serializeAs_GameFightTurnListMessage(output:IDataOutput) : void {
         output.writeShort(this.ids.length);
         var _i1:uint = 0;
         while(_i1 < this.ids.length)
         {
            output.writeInt(this.ids[_i1]);
            _i1++;
         }
         output.writeShort(this.deadsIds.length);
         var _i2:uint = 0;
         while(_i2 < this.deadsIds.length)
         {
            output.writeInt(this.deadsIds[_i2]);
            _i2++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightTurnListMessage(input);
      }
      
      public function deserializeAs_GameFightTurnListMessage(input:IDataInput) : void {
         var _val1:* = 0;
         var _val2:* = 0;
         var _idsLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _idsLen)
         {
            _val1 = input.readInt();
            this.ids.push(_val1);
            _i1++;
         }
         var _deadsIdsLen:uint = input.readUnsignedShort();
         var _i2:uint = 0;
         while(_i2 < _deadsIdsLen)
         {
            _val2 = input.readInt();
            this.deadsIds.push(_val2);
            _i2++;
         }
      }
   }
}
