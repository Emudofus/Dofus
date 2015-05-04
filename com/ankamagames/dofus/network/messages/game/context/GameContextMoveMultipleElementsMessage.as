package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.EntityMovementInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameContextMoveMultipleElementsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameContextMoveMultipleElementsMessage()
      {
         this.movements = new Vector.<EntityMovementInformations>();
         super();
      }
      
      public static const protocolId:uint = 254;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var movements:Vector.<EntityMovementInformations>;
      
      override public function getMessageId() : uint
      {
         return 254;
      }
      
      public function initGameContextMoveMultipleElementsMessage(param1:Vector.<EntityMovementInformations> = null) : GameContextMoveMultipleElementsMessage
      {
         this.movements = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.movements = new Vector.<EntityMovementInformations>();
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_GameContextMoveMultipleElementsMessage(param1);
      }
      
      public function serializeAs_GameContextMoveMultipleElementsMessage(param1:ICustomDataOutput) : void
      {
         param1.writeShort(this.movements.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.movements.length)
         {
            (this.movements[_loc2_] as EntityMovementInformations).serializeAs_EntityMovementInformations(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameContextMoveMultipleElementsMessage(param1);
      }
      
      public function deserializeAs_GameContextMoveMultipleElementsMessage(param1:ICustomDataInput) : void
      {
         var _loc4_:EntityMovementInformations = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new EntityMovementInformations();
            _loc4_.deserialize(param1);
            this.movements.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
