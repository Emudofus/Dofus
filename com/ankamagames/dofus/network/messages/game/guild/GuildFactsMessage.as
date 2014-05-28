package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.social.GuildFactSheetInformations;
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
      
      public function initGuildFactsMessage(infos:GuildFactSheetInformations = null, creationDate:uint = 0, nbTaxCollectors:uint = 0, enabled:Boolean = false, members:Vector.<CharacterMinimalInformations> = null) : GuildFactsMessage {
         this.infos = infos;
         this.creationDate = creationDate;
         this.nbTaxCollectors = nbTaxCollectors;
         this.enabled = enabled;
         this.members = members;
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
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_GuildFactsMessage(output);
      }
      
      public function serializeAs_GuildFactsMessage(output:IDataOutput) : void {
         output.writeShort(this.infos.getTypeId());
         this.infos.serialize(output);
         if(this.creationDate < 0)
         {
            throw new Error("Forbidden value (" + this.creationDate + ") on element creationDate.");
         }
         else
         {
            output.writeInt(this.creationDate);
            if(this.nbTaxCollectors < 0)
            {
               throw new Error("Forbidden value (" + this.nbTaxCollectors + ") on element nbTaxCollectors.");
            }
            else
            {
               output.writeShort(this.nbTaxCollectors);
               output.writeBoolean(this.enabled);
               output.writeShort(this.members.length);
               _i5 = 0;
               while(_i5 < this.members.length)
               {
                  (this.members[_i5] as CharacterMinimalInformations).serializeAs_CharacterMinimalInformations(output);
                  _i5++;
               }
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildFactsMessage(input);
      }
      
      public function deserializeAs_GuildFactsMessage(input:IDataInput) : void {
         var _item5:CharacterMinimalInformations = null;
         var _id1:uint = input.readUnsignedShort();
         this.infos = ProtocolTypeManager.getInstance(GuildFactSheetInformations,_id1);
         this.infos.deserialize(input);
         this.creationDate = input.readInt();
         if(this.creationDate < 0)
         {
            throw new Error("Forbidden value (" + this.creationDate + ") on element of GuildFactsMessage.creationDate.");
         }
         else
         {
            this.nbTaxCollectors = input.readShort();
            if(this.nbTaxCollectors < 0)
            {
               throw new Error("Forbidden value (" + this.nbTaxCollectors + ") on element of GuildFactsMessage.nbTaxCollectors.");
            }
            else
            {
               this.enabled = input.readBoolean();
               _membersLen = input.readUnsignedShort();
               _i5 = 0;
               while(_i5 < _membersLen)
               {
                  _item5 = new CharacterMinimalInformations();
                  _item5.deserialize(input);
                  this.members.push(_item5);
                  _i5++;
               }
               return;
            }
         }
      }
   }
}
