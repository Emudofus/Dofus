package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorBasicInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class TaxCollectorMovementMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TaxCollectorMovementMessage()
      {
         this.basicInfos = new TaxCollectorBasicInformations();
         super();
      }
      
      public static const protocolId:uint = 5633;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var hireOrFire:Boolean = false;
      
      public var basicInfos:TaxCollectorBasicInformations;
      
      public var playerId:uint = 0;
      
      public var playerName:String = "";
      
      override public function getMessageId() : uint
      {
         return 5633;
      }
      
      public function initTaxCollectorMovementMessage(param1:Boolean = false, param2:TaxCollectorBasicInformations = null, param3:uint = 0, param4:String = "") : TaxCollectorMovementMessage
      {
         this.hireOrFire = param1;
         this.basicInfos = param2;
         this.playerId = param3;
         this.playerName = param4;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.hireOrFire = false;
         this.basicInfos = new TaxCollectorBasicInformations();
         this.playerName = "";
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
         this.serializeAs_TaxCollectorMovementMessage(param1);
      }
      
      public function serializeAs_TaxCollectorMovementMessage(param1:ICustomDataOutput) : void
      {
         param1.writeBoolean(this.hireOrFire);
         this.basicInfos.serializeAs_TaxCollectorBasicInformations(param1);
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         else
         {
            param1.writeVarInt(this.playerId);
            param1.writeUTF(this.playerName);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorMovementMessage(param1);
      }
      
      public function deserializeAs_TaxCollectorMovementMessage(param1:ICustomDataInput) : void
      {
         this.hireOrFire = param1.readBoolean();
         this.basicInfos = new TaxCollectorBasicInformations();
         this.basicInfos.deserialize(param1);
         this.playerId = param1.readVarUhInt();
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of TaxCollectorMovementMessage.playerId.");
         }
         else
         {
            this.playerName = param1.readUTF();
            return;
         }
      }
   }
}
