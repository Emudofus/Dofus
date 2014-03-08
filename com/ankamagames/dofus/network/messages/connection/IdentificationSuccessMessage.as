package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   
   public class IdentificationSuccessMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function IdentificationSuccessMessage() {
         super();
      }
      
      public static const protocolId:uint = 22;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var login:String = "";
      
      public var nickname:String = "";
      
      public var accountId:uint = 0;
      
      public var communityId:uint = 0;
      
      public var hasRights:Boolean = false;
      
      public var secretQuestion:String = "";
      
      public var subscriptionEndDate:Number = 0;
      
      public var wasAlreadyConnected:Boolean = false;
      
      public var accountCreation:Number = 0;
      
      override public function getMessageId() : uint {
         return 22;
      }
      
      public function initIdentificationSuccessMessage(login:String="", nickname:String="", accountId:uint=0, communityId:uint=0, hasRights:Boolean=false, secretQuestion:String="", subscriptionEndDate:Number=0, wasAlreadyConnected:Boolean=false, accountCreation:Number=0) : IdentificationSuccessMessage {
         this.login = login;
         this.nickname = nickname;
         this.accountId = accountId;
         this.communityId = communityId;
         this.hasRights = hasRights;
         this.secretQuestion = secretQuestion;
         this.subscriptionEndDate = subscriptionEndDate;
         this.wasAlreadyConnected = wasAlreadyConnected;
         this.accountCreation = accountCreation;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.login = "";
         this.nickname = "";
         this.accountId = 0;
         this.communityId = 0;
         this.hasRights = false;
         this.secretQuestion = "";
         this.subscriptionEndDate = 0;
         this.wasAlreadyConnected = false;
         this.accountCreation = 0;
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
         this.serializeAs_IdentificationSuccessMessage(output);
      }
      
      public function serializeAs_IdentificationSuccessMessage(output:IDataOutput) : void {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.hasRights);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.wasAlreadyConnected);
         output.writeByte(_box0);
         output.writeUTF(this.login);
         output.writeUTF(this.nickname);
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
         }
         else
         {
            output.writeInt(this.accountId);
            if(this.communityId < 0)
            {
               throw new Error("Forbidden value (" + this.communityId + ") on element communityId.");
            }
            else
            {
               output.writeByte(this.communityId);
               output.writeUTF(this.secretQuestion);
               if(this.subscriptionEndDate < 0)
               {
                  throw new Error("Forbidden value (" + this.subscriptionEndDate + ") on element subscriptionEndDate.");
               }
               else
               {
                  output.writeDouble(this.subscriptionEndDate);
                  if(this.accountCreation < 0)
                  {
                     throw new Error("Forbidden value (" + this.accountCreation + ") on element accountCreation.");
                  }
                  else
                  {
                     output.writeDouble(this.accountCreation);
                     return;
                  }
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_IdentificationSuccessMessage(input);
      }
      
      public function deserializeAs_IdentificationSuccessMessage(input:IDataInput) : void {
         var _box0:uint = input.readByte();
         this.hasRights = BooleanByteWrapper.getFlag(_box0,0);
         this.wasAlreadyConnected = BooleanByteWrapper.getFlag(_box0,1);
         this.login = input.readUTF();
         this.nickname = input.readUTF();
         this.accountId = input.readInt();
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element of IdentificationSuccessMessage.accountId.");
         }
         else
         {
            this.communityId = input.readByte();
            if(this.communityId < 0)
            {
               throw new Error("Forbidden value (" + this.communityId + ") on element of IdentificationSuccessMessage.communityId.");
            }
            else
            {
               this.secretQuestion = input.readUTF();
               this.subscriptionEndDate = input.readDouble();
               if(this.subscriptionEndDate < 0)
               {
                  throw new Error("Forbidden value (" + this.subscriptionEndDate + ") on element of IdentificationSuccessMessage.subscriptionEndDate.");
               }
               else
               {
                  this.accountCreation = input.readDouble();
                  if(this.accountCreation < 0)
                  {
                     throw new Error("Forbidden value (" + this.accountCreation + ") on element of IdentificationSuccessMessage.accountCreation.");
                  }
                  else
                  {
                     return;
                  }
               }
            }
         }
      }
   }
}
