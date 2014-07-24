package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2api.PlayedCharacterApi;
   import d2components.GraphicContainer;
   import d2components.ButtonContainer;
   import d2components.Texture;
   import d2hooks.*;
   import d2actions.*;
   
   public class ChallengeDisplay extends Object
   {
      
      public function ChallengeDisplay() {
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var modCommon:Object;
      
      public var ctr_challenges:GraphicContainer;
      
      public var btn_minimize:ButtonContainer;
      
      public var btn_maximize:ButtonContainer;
      
      public var tx_background_grid:Texture;
      
      private var _foldStatus:Boolean;
      
      private var _challenges:Array;
      
      public function main(oParam:Object = null) : void {
         this.sysApi.addHook(ChallengeInfoUpdate,this.onChallengeInfoUpdate);
         this.sysApi.addHook(FoldAll,this.onFoldAll);
         this.btn_maximize.visible = false;
         this._challenges = new Array();
         this.updateChallengeList(oParam.challenges);
      }
      
      public function unload() : void {
      }
      
      private function updateChallengeList(challenges:Object) : void {
         var data:Object = null;
         var challenge:Object = null;
         var y:uint = 2;
         var i:uint = 0;
         for each(data in challenges)
         {
            if(this._challenges.length <= i)
            {
               challenge = new ChallengeEntry(this.uiApi.me(),this.ctr_challenges,data,0,y);
               this.uiApi.addComponentHook(challenge.btn_challenge,"onRelease");
               this.uiApi.addComponentHook(challenge.btn_challenge,"onRollOver");
               this.uiApi.addComponentHook(challenge.btn_challenge,"onRollOut");
               this._challenges.push(challenge);
            }
            else
            {
               this._challenges[i].data = data;
            }
            y = y + 52;
            i++;
         }
         this.tx_background_grid.height = y + 9;
      }
      
      private function _showChallengeList(value:Boolean) : void {
         this.ctr_challenges.visible = value;
         this.btn_minimize.visible = value;
         this.btn_maximize.visible = !value;
      }
      
      private function getChallengeByButton(button:Object) : ChallengeEntry {
         var challenge:ChallengeEntry = null;
         for each(challenge in this._challenges)
         {
            if(challenge.btn_challenge == button)
            {
               return challenge;
            }
         }
         return null;
      }
      
      public function onRelease(target:Object) : void {
         var challenge:ChallengeEntry = null;
         switch(target)
         {
            case this.btn_minimize:
               this._showChallengeList(false);
               break;
            case this.btn_maximize:
               this._showChallengeList(true);
               break;
            default:
               challenge = this.getChallengeByButton(target);
               if(challenge)
               {
                  this.uiApi.hideTooltip();
                  this.sysApi.sendAction(new ChallengeTargetsListRequest(challenge.data.id));
               }
         }
      }
      
      private function onFoldAll(fold:Boolean) : void {
         if(fold)
         {
            this._foldStatus = this.ctr_challenges.visible;
            this._showChallengeList(false);
         }
         else
         {
            this._showChallengeList(this._foldStatus);
         }
      }
      
      public function onRollOver(target:Object) : void {
         var challenge:ChallengeEntry = this.getChallengeByButton(target);
         if((challenge) && (challenge.data))
         {
            this.uiApi.showTooltip(challenge.data,target,false,"standard",0,2,3,null,null,null);
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onChallengeInfoUpdate(challenges:Object) : void {
         this.updateChallengeList(challenges);
      }
   }
}
