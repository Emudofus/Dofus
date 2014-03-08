package com.ankamagames.dofus.network.messages.game.approach
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ServerSettingsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ServerSettingsMessage() {
         super();
      }
      
      public static const protocolId:uint = 6340;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var lang:String = "";
      
      public var community:uint = 0;
      
      public var gameType:uint = 0;
      
      override public function getMessageId() : uint {
         return 6340;
      }
      
      public function initServerSettingsMessage(param1:String="", param2:uint=0, param3:uint=0) : ServerSettingsMessage {
         this.lang = param1;
         this.community = param2;
         this.gameType = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.lang = "";
         this.community = 0;
         this.gameType = 0;
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
         this.serializeAs_ServerSettingsMessage(param1);
      }
      
      public function serializeAs_ServerSettingsMessage(param1:IDataOutput) : void {
         param1.writeUTF(this.lang);
         if(this.community < 0)
         {
            throw new Error("Forbidden value (" + this.community + ") on element community.");
         }
         else
         {
            param1.writeByte(this.community);
            if(this.gameType < 0)
            {
               throw new Error("Forbidden value (" + this.gameType + ") on element gameType.");
            }
            else
            {
               param1.writeByte(this.gameType);
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ServerSettingsMessage(param1);
      }
      
      public function deserializeAs_ServerSettingsMessage(param1:IDataInput) : void {
         this.lang = param1.readUTF();
         this.community = param1.readByte();
         if(this.community < 0)
         {
            throw new Error("Forbidden value (" + this.community + ") on element of ServerSettingsMessage.community.");
         }
         else
         {
            this.gameType = param1.readByte();
            if(this.gameType < 0)
            {
               throw new Error("Forbidden value (" + this.gameType + ") on element of ServerSettingsMessage.gameType.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
