package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.EntityMovementInformations;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameContextMoveMultipleElementsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameContextMoveMultipleElementsMessage() {
         this.movements = new Vector.<EntityMovementInformations>();
         super();
      }
      
      public static const protocolId:uint = 254;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var movements:Vector.<EntityMovementInformations>;
      
      override public function getMessageId() : uint {
         return 254;
      }
      
      public function initGameContextMoveMultipleElementsMessage(movements:Vector.<EntityMovementInformations>=null) : GameContextMoveMultipleElementsMessage {
         this.movements = movements;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.movements = new Vector.<EntityMovementInformations>();
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
         this.serializeAs_GameContextMoveMultipleElementsMessage(output);
      }
      
      public function serializeAs_GameContextMoveMultipleElementsMessage(output:IDataOutput) : void {
         output.writeShort(this.movements.length);
         var _i1:uint = 0;
         while(_i1 < this.movements.length)
         {
            (this.movements[_i1] as EntityMovementInformations).serializeAs_EntityMovementInformations(output);
            _i1++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameContextMoveMultipleElementsMessage(input);
      }
      
      public function deserializeAs_GameContextMoveMultipleElementsMessage(input:IDataInput) : void {
         var _item1:EntityMovementInformations = null;
         var _movementsLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _movementsLen)
         {
            _item1 = new EntityMovementInformations();
            _item1.deserialize(input);
            this.movements.push(_item1);
            _i1++;
         }
      }
   }
}
