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
      
      public function initGameContextMoveElementMessage(param1:EntityMovementInformations=null) : GameContextMoveElementMessage {
         this.movement = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.movement = new EntityMovementInformations();
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameContextMoveElementMessage(param1);
      }
      
      public function serializeAs_GameContextMoveElementMessage(param1:IDataOutput) : void {
         this.movement.serializeAs_EntityMovementInformations(param1);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameContextMoveElementMessage(param1);
      }
      
      public function deserializeAs_GameContextMoveElementMessage(param1:IDataInput) : void {
         this.movement = new EntityMovementInformations();
         this.movement.deserialize(param1);
      }
   }
}
