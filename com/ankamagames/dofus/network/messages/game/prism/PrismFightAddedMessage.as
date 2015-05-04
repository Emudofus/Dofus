package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.prism.PrismFightersInformation;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class PrismFightAddedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PrismFightAddedMessage()
      {
         this.fight = new PrismFightersInformation();
         super();
      }
      
      public static const protocolId:uint = 6452;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var fight:PrismFightersInformation;
      
      override public function getMessageId() : uint
      {
         return 6452;
      }
      
      public function initPrismFightAddedMessage(param1:PrismFightersInformation = null) : PrismFightAddedMessage
      {
         this.fight = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.fight = new PrismFightersInformation();
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
         this.serializeAs_PrismFightAddedMessage(param1);
      }
      
      public function serializeAs_PrismFightAddedMessage(param1:ICustomDataOutput) : void
      {
         this.fight.serializeAs_PrismFightersInformation(param1);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_PrismFightAddedMessage(param1);
      }
      
      public function deserializeAs_PrismFightAddedMessage(param1:ICustomDataInput) : void
      {
         this.fight = new PrismFightersInformation();
         this.fight.deserialize(param1);
      }
   }
}
