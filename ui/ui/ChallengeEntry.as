package ui
{
   import d2hooks.*;
   import d2actions.*;
   
   public class ChallengeEntry extends Object
   {
      
      public function ChallengeEntry(challengeUi:Object, parent:Object, data:Object, x:uint, y:uint) {
         super();
         this._challengeUi = challengeUi;
         this.data = data;
         this.display(parent,x,y);
      }
      
      public static const STATE_INPROGRESS:uint = 0;
      
      public static const STATE_COMPLETE:uint = 1;
      
      public static const STATE_FAILED:uint = 2;
      
      public var btn_challenge:Object;
      
      public var tx_result_challenge:Object;
      
      public var tx_slot_challenge:Object;
      
      public var tx_picto_challenge:Object;
      
      private var _data:Object;
      
      private var _state:Object;
      
      private var _challengeUi:Object;
      
      public function set data(data:Object) : void {
         this._data = data;
         if(this.tx_picto_challenge)
         {
            this.tx_picto_challenge.uri = data.iconUri;
         }
         this.state = data.result;
      }
      
      public function get data() : Object {
         return this._data;
      }
      
      public function set state(st:uint) : void {
         this._state = st;
         this.refresh_state();
      }
      
      private function display(parent:Object, x:uint, y:uint) : void {
         this.btn_challenge = Api.uiApi.createContainer("ButtonContainer");
         this.btn_challenge.x = x;
         this.btn_challenge.y = y;
         this.btn_challenge.changingStateData = new Array();
         this.btn_challenge.finalize();
         this.tx_slot_challenge = Api.uiApi.createComponent("Texture");
         this.tx_slot_challenge.x = 9;
         this.tx_slot_challenge.y = 4;
         this.tx_slot_challenge.width = 48;
         this.tx_slot_challenge.height = 48;
         this.tx_slot_challenge.name = "tx_slot_challenge";
         this.tx_slot_challenge.dispatchMessages = true;
         this.tx_slot_challenge.uri = Api.uiApi.createUri(this._challengeUi.getConstant("assets") + "buff_slot_background");
         this.tx_slot_challenge.autoGrid = false;
         this.tx_slot_challenge.finalize();
         this.btn_challenge.addChild(this.tx_slot_challenge);
         this.tx_picto_challenge = Api.uiApi.createComponent("Texture");
         this.tx_picto_challenge.x = 13;
         this.tx_picto_challenge.y = 9;
         this.tx_picto_challenge.width = 40;
         this.tx_picto_challenge.height = 40;
         this.tx_picto_challenge.name = "tx_picto_challenge";
         this.tx_picto_challenge.uri = this._data.iconUri;
         this.tx_picto_challenge.autoGrid = false;
         this.tx_picto_challenge.dispatchMessages = true;
         this.tx_picto_challenge.finalize();
         this.btn_challenge.addChild(this.tx_picto_challenge);
         this.tx_result_challenge = Api.uiApi.createComponent("Texture");
         this.tx_result_challenge.x = 13;
         this.tx_result_challenge.y = 9;
         this.tx_result_challenge.width = 40;
         this.tx_result_challenge.height = 40;
         this.tx_result_challenge.uri = Api.uiApi.createUri(this._challengeUi.getConstant("assets") + "Challenge_tx_Perdu");
         this.tx_result_challenge.autoGrid = false;
         this.tx_result_challenge.dispatchMessages = true;
         this.tx_result_challenge.finalize();
         this.btn_challenge.addChild(this.tx_result_challenge);
         parent.addChild(this.btn_challenge);
         this.refresh_state();
      }
      
      private function refresh_state() : void {
         if(this.tx_result_challenge)
         {
            switch(this._state)
            {
               case STATE_INPROGRESS:
                  this.tx_result_challenge.visible = false;
                  break;
               case STATE_COMPLETE:
                  this.tx_result_challenge.visible = true;
                  this.tx_result_challenge.uri = Api.uiApi.createUri(this._challengeUi.getConstant("assets") + "Challenge_tx_Gagne");
                  break;
               case STATE_FAILED:
                  this.tx_result_challenge.visible = true;
                  this.tx_result_challenge.uri = Api.uiApi.createUri(this._challengeUi.getConstant("assets") + "Challenge_tx_Perdu");
            }
         }
      }
   }
}
