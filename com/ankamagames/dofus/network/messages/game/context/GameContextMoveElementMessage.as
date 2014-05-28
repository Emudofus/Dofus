package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.EntityMovementInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameContextMoveElementMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameContextMoveElementMessage() {
         this.movement = new EntityMovementInformations();
         super();
      }
      
      public static const protocolId:uint = 253;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var movement:EntityMovementInformations;
      
      override public function getMessageId() : uint {
         return 253;
      }
      
      public function initGameContextMoveElementMessage(movement:EntityMovementInformations = null) : GameContextMoveElementMessage {
         this.movement = movement;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.movement = new EntityMovementInformations();
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
         this.serializeAs_GameContextMoveElementMessage(output);
      }
      
      public function serializeAs_GameContextMoveElementMessage(output:IDataOutput) : void {
         this.movement.serializeAs_EntityMovementInformations(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameContextMoveElementMessage(input);
      }
      
      public function deserializeAs_GameContextMoveElementMessage(input:IDataInput) : void {
         this.movement = new EntityMovementInformations();
         this.movement.deserialize(input);
      }
   }
}
