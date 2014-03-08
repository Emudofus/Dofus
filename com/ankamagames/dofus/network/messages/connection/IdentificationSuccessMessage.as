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
      
      public function initIdentificationSuccessMessage(param1:String="", param2:String="", param3:uint=0, param4:uint=0, param5:Boolean=false, param6:String="", param7:Number=0, param8:Boolean=false, param9:Number=0) : IdentificationSuccessMessage {
         this.login = param1;
         this.nickname = param2;
         this.accountId = param3;
         this.communityId = param4;
         this.hasRights = param5;
         this.secretQuestion = param6;
         this.subscriptionEndDate = param7;
         this.wasAlreadyConnected = param8;
         this.accountCreation = param9;
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
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_IdentificationSuccessMessage(param1);
      }
      
      public function serializeAs_IdentificationSuccessMessage(param1:IDataOutput) : void {
         var _loc2_:uint = 0;
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,0,this.hasRights);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,1,this.wasAlreadyConnected);
         param1.writeByte(_loc2_);
         param1.writeUTF(this.login);
         param1.writeUTF(this.nickname);
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
         }
         else
         {
            param1.writeInt(this.accountId);
            if(this.communityId < 0)
            {
               throw new Error("Forbidden value (" + this.communityId + ") on element communityId.");
            }
            else
            {
               param1.writeByte(this.communityId);
               param1.writeUTF(this.secretQuestion);
               if(this.subscriptionEndDate < 0)
               {
                  throw new Error("Forbidden value (" + this.subscriptionEndDate + ") on element subscriptionEndDate.");
               }
               else
               {
                  param1.writeDouble(this.subscriptionEndDate);
                  if(this.accountCreation < 0)
                  {
                     throw new Error("Forbidden value (" + this.accountCreation + ") on element accountCreation.");
                  }
                  else
                  {
                     param1.writeDouble(this.accountCreation);
                     return;
                  }
               }
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_IdentificationSuccessMessage(param1);
      }
      
      public function deserializeAs_IdentificationSuccessMessage(param1:IDataInput) : void {
         var _loc2_:uint = param1.readByte();
         this.hasRights = BooleanByteWrapper.getFlag(_loc2_,0);
         this.wasAlreadyConnected = BooleanByteWrapper.getFlag(_loc2_,1);
         this.login = param1.readUTF();
         this.nickname = param1.readUTF();
         this.accountId = param1.readInt();
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element of IdentificationSuccessMessage.accountId.");
         }
         else
         {
            this.communityId = param1.readByte();
            if(this.communityId < 0)
            {
               throw new Error("Forbidden value (" + this.communityId + ") on element of IdentificationSuccessMessage.communityId.");
            }
            else
            {
               this.secretQuestion = param1.readUTF();
               this.subscriptionEndDate = param1.readDouble();
               if(this.subscriptionEndDate < 0)
               {
                  throw new Error("Forbidden value (" + this.subscriptionEndDate + ") on element of IdentificationSuccessMessage.subscriptionEndDate.");
               }
               else
               {
                  this.accountCreation = param1.readDouble();
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
