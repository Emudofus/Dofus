package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildListMessage() {
         this.guilds = new Vector.<GuildInformations>();
         super();
      }
      
      public static const protocolId:uint = 6413;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var guilds:Vector.<GuildInformations>;
      
      override public function getMessageId() : uint {
         return 6413;
      }
      
      public function initGuildListMessage(guilds:Vector.<GuildInformations> = null) : GuildListMessage {
         this.guilds = guilds;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.guilds = new Vector.<GuildInformations>();
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
         this.serializeAs_GuildListMessage(output);
      }
      
      public function serializeAs_GuildListMessage(output:IDataOutput) : void {
         output.writeShort(this.guilds.length);
         var _i1:uint = 0;
         while(_i1 < this.guilds.length)
         {
            (this.guilds[_i1] as GuildInformations).serializeAs_GuildInformations(output);
            _i1++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildListMessage(input);
      }
      
      public function deserializeAs_GuildListMessage(input:IDataInput) : void {
         var _item1:GuildInformations = null;
         var _guildsLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _guildsLen)
         {
            _item1 = new GuildInformations();
            _item1.deserialize(input);
            this.guilds.push(_item1);
            _i1++;
         }
      }
   }
}
