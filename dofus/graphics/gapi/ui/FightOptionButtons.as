// Action script...

// [Initial MovieClip Action of sprite 20841]
#initclip 106
if (!dofus.graphics.gapi.ui.FightOptionButtons)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.gapi)
    {
        _global.dofus.graphics.gapi = new Object();
    } // end if
    if (!dofus.graphics.gapi.ui)
    {
        _global.dofus.graphics.gapi.ui = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.FightOptionButtons = function ()
    {
        super();
    }).prototype;
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.FightOptionButtons.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
    };
    _loc1.addListeners = function ()
    {
        this._btnFlag.addEventListener("click", this);
        this._btnFlag.addEventListener("over", this);
        this._btnFlag.addEventListener("out", this);
        this._btnBlockJoinerExceptParty.addEventListener("click", this);
        this._btnBlockJoinerExceptParty.addEventListener("over", this);
        this._btnBlockJoinerExceptParty.addEventListener("out", this);
        this._btnBlockJoiner.addEventListener("click", this);
        this._btnBlockJoiner.addEventListener("over", this);
        this._btnBlockJoiner.addEventListener("out", this);
        this._btnHelp.addEventListener("click", this);
        this._btnHelp.addEventListener("over", this);
        this._btnHelp.addEventListener("out", this);
        this._btnBlockSpectators.addEventListener("click", this);
        this._btnBlockSpectators.addEventListener("over", this);
        this._btnBlockSpectators.addEventListener("out", this);
        this._btnToggleSprites.addEventListener("click", this);
        this._btnToggleSprites.addEventListener("over", this);
        this._btnToggleSprites.addEventListener("out", this);
    };
    _loc1.initData = function ()
    {
        if (!this.api.datacenter.Player.inParty)
        {
            this._btnBlockJoinerExceptParty._visible = false;
        }
        else
        {
            this._btnBlockJoinerExceptParty.selected = this.api.kernel.OptionsManager.getOption("FightGroupAutoLock");
            if (this._btnBlockJoinerExceptParty.selected)
            {
                this.api.network.Fights.blockJoinerExceptParty();
            } // end if
        } // end else if
        this._btnToggleSprites._visible = false;
    };
    _loc1.onGameRunning = function ()
    {
        this._btnBlockJoinerExceptParty._visible = false;
        this._btnBlockJoiner._visible = false;
        this._btnHelp._visible = false;
        this._btnToggleSprites._visible = true;
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnFlag:
            {
                this.api.kernel.GameManager.switchToFlagSet();
                break;
            } 
            case this._btnBlockJoinerExceptParty:
            {
                this.api.network.Fights.blockJoinerExceptParty();
                break;
            } 
            case this._btnBlockJoiner:
            {
                this.api.network.Fights.blockJoiner();
                break;
            } 
            case this._btnHelp:
            {
                this.api.network.Fights.needHelp();
                break;
            } 
            case this._btnBlockSpectators:
            {
                this.api.network.Fights.blockSpectators();
                break;
            } 
            case this._btnToggleSprites:
            {
                this.api.datacenter.Basics.gfx_isSpritesHidden = !this.api.datacenter.Basics.gfx_isSpritesHidden;
                if (this.api.datacenter.Basics.gfx_isSpritesHidden)
                {
                    this.api.gfx.spriteHandler.maskAllSprites();
                }
                else
                {
                    this.api.gfx.spriteHandler.unmaskAllSprites();
                } // end else if
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnFlag:
            {
                this.gapi.showTooltip(this.api.lang.getText("FLAG_INDICATOR_HELP"), this._btnFlag, -30);
                break;
            } 
            case this._btnBlockJoinerExceptParty:
            {
                this.gapi.showTooltip(this.api.lang.getText("FIGHT_OPTION_BLOCKJOINEREXCEPTPARTY"), this._btnFlag, -30);
                break;
            } 
            case this._btnBlockJoiner:
            {
                this.gapi.showTooltip(this.api.lang.getText("FIGHT_OPTION_BLOCKJOINER"), this._btnFlag, -30);
                break;
            } 
            case this._btnHelp:
            {
                this.gapi.showTooltip(this.api.lang.getText("FIGHT_OPTION_HELP"), this._btnFlag, -30);
                break;
            } 
            case this._btnBlockSpectators:
            {
                this.gapi.showTooltip(this.api.lang.getText("FIGHT_OPTION_SPECTATOR"), this._btnFlag, -30);
                break;
            } 
            case this._btnToggleSprites:
            {
                this.gapi.showTooltip(this.api.lang.getText("FIGHT_OPTION_SPRITES"), this._btnFlag, -30);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.FightOptionButtons = function ()
    {
        super();
    }).CLASS_NAME = "FightOptionButtons";
} // end if
#endinitclip
