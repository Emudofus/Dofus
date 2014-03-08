package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorFightersInformation;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class TaxCollectorListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TaxCollectorListMessage() {
         this.informations = new Vector.<TaxCollectorInformations>();
         this.fightersInformations = new Vector.<TaxCollectorFightersInformation>();
         super();
      }
      
      public static const protocolId:uint = 5930;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var nbcollectorMax:uint = 0;
      
      public var informations:Vector.<TaxCollectorInformations>;
      
      public var fightersInformations:Vector.<TaxCollectorFightersInformation>;
      
      override public function getMessageId() : uint {
         return 5930;
      }
      
      public function initTaxCollectorListMessage(param1:uint=0, param2:Vector.<TaxCollectorInformations>=null, param3:Vector.<TaxCollectorFightersInformation>=null) : TaxCollectorListMessage {
         this.nbcollectorMax = param1;
         this.informations = param2;
         this.fightersInformations = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.nbcollectorMax = 0;
         this.informations = new Vector.<TaxCollectorInformations>();
         this.fightersInformations = new Vector.<TaxCollectorFightersInformation>();
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
         this.serializeAs_TaxCollectorListMessage(param1);
      }
      
      public function serializeAs_TaxCollectorListMessage(param1:IDataOutput) : void {
         if(this.nbcollectorMax < 0)
         {
            throw new Error("Forbidden value (" + this.nbcollectorMax + ") on element nbcollectorMax.");
         }
         else
         {
            param1.writeByte(this.nbcollectorMax);
            param1.writeShort(this.informations.length);
            _loc2_ = 0;
            while(_loc2_ < this.informations.length)
            {
               param1.writeShort((this.informations[_loc2_] as TaxCollectorInformations).getTypeId());
               (this.informations[_loc2_] as TaxCollectorInformations).serialize(param1);
               _loc2_++;
            }
            param1.writeShort(this.fightersInformations.length);
            _loc3_ = 0;
            while(_loc3_ < this.fightersInformations.length)
            {
               (this.fightersInformations[_loc3_] as TaxCollectorFightersInformation).serializeAs_TaxCollectorFightersInformation(param1);
               _loc3_++;
            }
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_TaxCollectorListMessage(param1);
      }
      
      public function deserializeAs_TaxCollectorListMessage(param1:IDataInput) : void {
         var _loc6_:uint = 0;
         var _loc7_:TaxCollectorInformations = null;
         var _loc8_:TaxCollectorFightersInformation = null;
         this.nbcollectorMax = param1.readByte();
         if(this.nbcollectorMax < 0)
         {
            throw new Error("Forbidden value (" + this.nbcollectorMax + ") on element of TaxCollectorListMessage.nbcollectorMax.");
         }
         else
         {
            _loc2_ = param1.readUnsignedShort();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc6_ = param1.readUnsignedShort();
               _loc7_ = ProtocolTypeManager.getInstance(TaxCollectorInformations,_loc6_);
               _loc7_.deserialize(param1);
               this.informations.push(_loc7_);
               _loc3_++;
            }
            _loc4_ = param1.readUnsignedShort();
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc8_ = new TaxCollectorFightersInformation();
               _loc8_.deserialize(param1);
               this.fightersInformations.push(_loc8_);
               _loc5_++;
            }
            return;
         }
      }
   }
}
