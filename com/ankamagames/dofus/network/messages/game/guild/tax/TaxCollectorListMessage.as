package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorFightersInformation;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class TaxCollectorListMessage extends AbstractTaxCollectorListMessage implements INetworkMessage
   {
      
      public function TaxCollectorListMessage()
      {
         this.fightersInformations = new Vector.<TaxCollectorFightersInformation>();
         super();
      }
      
      public static const protocolId:uint = 5930;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var nbcollectorMax:uint = 0;
      
      public var fightersInformations:Vector.<TaxCollectorFightersInformation>;
      
      override public function getMessageId() : uint
      {
         return 5930;
      }
      
      public function initTaxCollectorListMessage(param1:Vector.<TaxCollectorInformations> = null, param2:uint = 0, param3:Vector.<TaxCollectorFightersInformation> = null) : TaxCollectorListMessage
      {
         super.initAbstractTaxCollectorListMessage(param1);
         this.nbcollectorMax = param2;
         this.fightersInformations = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.nbcollectorMax = 0;
         this.fightersInformations = new Vector.<TaxCollectorFightersInformation>();
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
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_TaxCollectorListMessage(param1);
      }
      
      public function serializeAs_TaxCollectorListMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractTaxCollectorListMessage(param1);
         if(this.nbcollectorMax < 0)
         {
            throw new Error("Forbidden value (" + this.nbcollectorMax + ") on element nbcollectorMax.");
         }
         else
         {
            param1.writeByte(this.nbcollectorMax);
            param1.writeShort(this.fightersInformations.length);
            var _loc2_:uint = 0;
            while(_loc2_ < this.fightersInformations.length)
            {
               (this.fightersInformations[_loc2_] as TaxCollectorFightersInformation).serializeAs_TaxCollectorFightersInformation(param1);
               _loc2_++;
            }
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorListMessage(param1);
      }
      
      public function deserializeAs_TaxCollectorListMessage(param1:ICustomDataInput) : void
      {
         var _loc4_:TaxCollectorFightersInformation = null;
         super.deserialize(param1);
         this.nbcollectorMax = param1.readByte();
         if(this.nbcollectorMax < 0)
         {
            throw new Error("Forbidden value (" + this.nbcollectorMax + ") on element of TaxCollectorListMessage.nbcollectorMax.");
         }
         else
         {
            var _loc2_:uint = param1.readUnsignedShort();
            var _loc3_:uint = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = new TaxCollectorFightersInformation();
               _loc4_.deserialize(param1);
               this.fightersInformations.push(_loc4_);
               _loc3_++;
            }
            return;
         }
      }
   }
}
