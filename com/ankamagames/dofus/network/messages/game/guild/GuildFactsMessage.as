package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.social.GuildFactSheetInformations;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class GuildFactsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildFactsMessage() {
         this.infos = new GuildFactSheetInformations();
         this.members = new Vector.<CharacterMinimalInformations>();
         super();
      }
      
      public static const protocolId:uint = 6415;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var infos:GuildFactSheetInformations;
      
      public var creationDate:uint = 0;
      
      public var nbTaxCollectors:uint = 0;
      
      public var enabled:Boolean = false;
      
      public var members:Vector.<CharacterMinimalInformations>;
      
      override public function getMessageId() : uint {
         return 6415;
      }
      
      public function initGuildFactsMessage(param1:GuildFactSheetInformations=null, param2:uint=0, param3:uint=0, param4:Boolean=false, param5:Vector.<CharacterMinimalInformations>=null) : GuildFactsMessage {
         this.infos = param1;
         this.creationDate = param2;
         this.nbTaxCollectors = param3;
         this.enabled = param4;
         this.members = param5;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.infos = new GuildFactSheetInformations();
         this.nbTaxCollectors = 0;
         this.enabled = false;
         this.members = new Vector.<CharacterMinimalInformations>();
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
         this.serializeAs_GuildFactsMessage(param1);
      }
      
      public function serializeAs_GuildFactsMessage(param1:IDataOutput) : void {
         param1.writeShort(this.infos.getTypeId());
         this.infos.serialize(param1);
         if(this.creationDate < 0)
         {
            throw new Error("Forbidden value (" + this.creationDate + ") on element creationDate.");
         }
         else
         {
            param1.writeInt(this.creationDate);
            if(this.nbTaxCollectors < 0)
            {
               throw new Error("Forbidden value (" + this.nbTaxCollectors + ") on element nbTaxCollectors.");
            }
            else
            {
               param1.writeShort(this.nbTaxCollectors);
               param1.writeBoolean(this.enabled);
               param1.writeShort(this.members.length);
               _loc2_ = 0;
               while(_loc2_ < this.members.length)
               {
                  (this.members[_loc2_] as CharacterMinimalInformations).serializeAs_CharacterMinimalInformations(param1);
                  _loc2_++;
               }
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildFactsMessage(param1);
      }
      
      public function deserializeAs_GuildFactsMessage(param1:IDataInput) : void {
         var _loc5_:CharacterMinimalInformations = null;
         var _loc2_:uint = param1.readUnsignedShort();
         this.infos = ProtocolTypeManager.getInstance(GuildFactSheetInformations,_loc2_);
         this.infos.deserialize(param1);
         this.creationDate = param1.readInt();
         if(this.creationDate < 0)
         {
            throw new Error("Forbidden value (" + this.creationDate + ") on element of GuildFactsMessage.creationDate.");
         }
         else
         {
            this.nbTaxCollectors = param1.readShort();
            if(this.nbTaxCollectors < 0)
            {
               throw new Error("Forbidden value (" + this.nbTaxCollectors + ") on element of GuildFactsMessage.nbTaxCollectors.");
            }
            else
            {
               this.enabled = param1.readBoolean();
               _loc3_ = param1.readUnsignedShort();
               _loc4_ = 0;
               while(_loc4_ < _loc3_)
               {
                  _loc5_ = new CharacterMinimalInformations();
                  _loc5_.deserialize(param1);
                  this.members.push(_loc5_);
                  _loc4_++;
               }
               return;
            }
         }
      }
   }
}
