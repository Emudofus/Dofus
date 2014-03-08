package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
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
      
      public function initGuildListMessage(param1:Vector.<GuildInformations>=null) : GuildListMessage {
         this.guilds = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.guilds = new Vector.<GuildInformations>();
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
         this.serializeAs_GuildListMessage(param1);
      }
      
      public function serializeAs_GuildListMessage(param1:IDataOutput) : void {
         param1.writeShort(this.guilds.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.guilds.length)
         {
            (this.guilds[_loc2_] as GuildInformations).serializeAs_GuildInformations(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildListMessage(param1);
      }
      
      public function deserializeAs_GuildListMessage(param1:IDataInput) : void {
         var _loc4_:GuildInformations = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new GuildInformations();
            _loc4_.deserialize(param1);
            this.guilds.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
