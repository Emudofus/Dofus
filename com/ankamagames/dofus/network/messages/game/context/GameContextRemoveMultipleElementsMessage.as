package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameContextRemoveMultipleElementsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameContextRemoveMultipleElementsMessage() {
         this.id = new Vector.<int>();
         super();
      }
      
      public static const protocolId:uint = 252;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var id:Vector.<int>;
      
      override public function getMessageId() : uint {
         return 252;
      }
      
      public function initGameContextRemoveMultipleElementsMessage(id:Vector.<int>=null) : GameContextRemoveMultipleElementsMessage {
         this.id = id;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.id = new Vector.<int>();
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
         this.serializeAs_GameContextRemoveMultipleElementsMessage(output);
      }
      
      public function serializeAs_GameContextRemoveMultipleElementsMessage(output:IDataOutput) : void {
         output.writeShort(this.id.length);
         var _i1:uint = 0;
         while(_i1 < this.id.length)
         {
            output.writeInt(this.id[_i1]);
            _i1++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameContextRemoveMultipleElementsMessage(input);
      }
      
      public function deserializeAs_GameContextRemoveMultipleElementsMessage(input:IDataInput) : void {
         var _val1:* = 0;
         var _idLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _idLen)
         {
            _val1 = input.readInt();
            this.id.push(_val1);
            _i1++;
         }
      }
   }
}
