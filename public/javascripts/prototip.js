//  Prototip 1.0.1.1
//  by Nick Stakenburg - http://www.nickstakenburg.com
//  25-07-2007
//
//  More information on this project:
//  http://www.nickstakenburg.com/projects/prototip/
//
//  Prototip is distributed under the MIT Open Source Licence
//

var Tip = Class.create();
Tip.prototype = {

  initialize: function(element, content) {
    this.element = $(element);
    this.content = content;

    this.options = Object.extend({
      className: 'tooltip',
      duration: 0.3,					// duration of the effect
      effect: false,					// false, 'appear' or 'blind'
      hook: false,						// { element: {'topLeft|topRight|bottomLeft|bottomRight'}, tip: {'topLeft|topRight|bottomLeft|bottomRight'}
      offset: (arguments[2] && arguments[2].hook) ? {x:0, y:0} : {x:16, y:16},
      fixed: false,						// follow the mouse if false
      target: this.element,				// or another element
      title: false,
      viewport: true,					// keep within viewport if mouse is followed
	  zIndex: 1200
    }, arguments[2] || {});

    this.target = $(this.options.target);

    if (this.options.hook) {
      this.options.fixed = true;
      this.options.viewport = false;
    }

	if (this.options.effect) {
	  this.queue = { position: 'end', limit: 1, scope: ''}
	  var c = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
	  for (var i=0; i<6; i++) {
        var r = Math.floor(Math.random() * c.length);
        this.queue.scope += c.substring(r,r+1);
      }
    }

    this.setup();
  },

  setup: function() {
    this.element.observe('mousemove', this.showTip.safeBind(this));
    this.element.observe('mouseout', this.hideTip.safeBind(this));
  },

  buildTip: function() {
    // IE select fix, this is placed first in case zIndex fails
    if (Prototype.Browser.IE) {
      this.underlay = document.createElement('iframe');
      Element.setStyle(this.underlay, {
        position: 'absolute',
        display: 'none',
        border: 0,
        margin: 0,
        opacity: 0.01,
        padding: 0,
        background: 'none',
        zIndex: this.options.zIndex
      });
      document.body.appendChild(this.underlay);
    }

    // create a wrapper
    this.wrapper = document.createElement('div');
    Element.setStyle(this.wrapper, {
      position: 'absolute',
      zIndex: this.options.zIndex+1,
      display: 'none'
    });
    if (this.options.width) this.wrapper.setStyle({ width: this.options.width+'px' });

    // add the tooltip
    this.tooltip = this.wrapper.appendChild(document.createElement('div'));
    this.tooltip.className = this.options.className;
    this.tooltip.style.position = 'relative';

    // add the title
    if (this.options.title) {
      this.title = this.tooltip.appendChild(document.createElement('div'));
      this.title.className = 'title';
      Element.update(this.title, this.options.title);
    }

    // content
    this.tip = this.tooltip.appendChild(document.createElement('div'));
    this.tip.className = 'content';
    Element.update(this.tip, this.content);

    // add wrapper to the body
    document.body.appendChild(this.wrapper);

    // prepare for effects
    var w = this.wrapper.getDimensions();
    this.wrapper.setStyle({ width: w.width+'px', height: w.height+'px' });
    if (Prototype.Browser.IE) this.underlay.setStyle({ width: w.width+'px', height: w.height+'px' });
    Element.hide(this.tooltip);
  },

  showTip: function(event){
    if (!this.wrapper) this.buildTip();
    this.positionTip(event); // follow mouse
    if (this.wrapper.visible() && this.options.effect != 'appear') return;

    if (Prototype.Browser.IE) this.underlay.show(); // IE select fix
    this.wrapper.show();

    if (!this.options.effect) {
      this.tooltip.show(); 
    } else {
      // stop running effect
	  if (this.activeEffect) Effect.Queues.get(this.queue.scope).remove(this.activeEffect);
      // start new
	  this.activeEffect = Effect[Effect.PAIRS[this.options.effect][0]](this.tooltip, { duration: this.options.duration, queue: this.queue});
	}
  },

  hideTip: function(event){
    if(!this.wrapper.visible()) return;
	
	if (!this.options.effect) {
      if (Prototype.Browser.IE) { this.underlay.hide(); } // select fix
      this.tooltip.hide();
      this.wrapper.hide();
    }
    else {
      // stop running effect
	  if (this.activeEffect) Effect.Queues.get(this.queue.scope).remove(this.activeEffect);
      // start new
	  this.activeEffect = Effect[Effect.PAIRS[this.options.effect][1]](this.tooltip, { duration: this.options.duration, queue: this.queue, afterFinish: function(){
        if (Prototype.Browser.IE) this.underlay.hide(); // select fix
        this.wrapper.hide();
      }.bind(this)});
    }
  },

  positionTip: function(event){
    // calculate
    var offset = {'left': this.options.offset.x,'top': this.options.offset.y};
    var targetPosition = Position.cumulativeOffset(this.target);
    var tipd = this.wrapper.getDimensions();
    var pos = {
      'left': (this.options.fixed) ? targetPosition[0] : Event.pointerX(event),
      'top': (this.options.fixed) ? targetPosition[1] : Event.pointerY(event)
    }

    // add offsets
    pos.left += offset.left;
    pos.top += offset.top;

    if (this.options.hook) {
      var dims = {'target': this.target.getDimensions(), 'tip': tipd}
      var hooks = {'target': Position.cumulativeOffset(this.target), 'tip': Position.cumulativeOffset(this.target)}

      for(var z in hooks) {
        switch(this.options.hook[z]){
          case 'topRight':
            hooks[z][0] += dims[z].width;
            break;
          case 'bottomLeft':
            hooks[z][1] += dims[z].height;
            break;
          case 'bottomRight':
            hooks[z][0] += dims[z].width;
            hooks[z][1] += dims[z].height;
            break;
        }
      }

      // move based on hooks
      pos.left += -1*(hooks.tip[0] - hooks.target[0]);
      pos.top += -1*(hooks.tip[1] - hooks.target[1]);
    }

    // move tooltip when there is a different target when following mouse
    if (!this.options.fixed && this.element !== this.target) {
      var elementPosition = Position.cumulativeOffset(this.element);
      pos.left += -1*(elementPosition[0] - targetPosition[0]);
      pos.top += -1*(elementPosition[1] - targetPosition[1]);
	}

    if (!this.options.fixed && this.options.viewport) {
      var scroll = this.getScrollOffsets();
      var viewport = this.viewportSize();
      var pair = {'left': 'width', 'top': 'height'};

      for(var z in pair) {
        if ((pos[z] + tipd[pair[z]] - scroll[z]) > viewport[pair[z]]) {
          pos[z] = pos[z] - tipd[pair[z]] - 2*offset[z];
		}
      }
    }

    // position
    this.wrapper.setStyle({
      left: pos.left + 'px',
      top: pos.top + 'px'
    });

    if (Prototype.Browser.IE) this.underlay.setStyle({ left: pos.left+'px', top: pos.top+'px' });
  },

  // Functions below hopefully won't be needed with prototype 1.6
  viewportWidth: function(){
    if (Prototype.Browser.Opera) return document.body.clientWidth;
    return document.documentElement.clientWidth;
  },

  viewportHeight: function(){
    if (Prototype.Browser.Opera) return document.body.clientHeight;
    if (Prototype.Browser.WebKit) return this.innerHeight;
    return document.documentElement.clientHeight;
  },

  viewportSize : function(){
    return {'height': this.viewportHeight(), 'width': this.viewportWidth()};
  },

  getScrollLeft: function(){
	  return this.pageXOffset || document.documentElement.scrollLeft;
  },
  
  getScrollTop: function(){
    return this.pageYOffset || document.documentElement.scrollTop;
  },

  getScrollOffsets: function(){
    return {'left': this.getScrollLeft(), 'top': this.getScrollTop()}
  }
}

/* fix for $A is not defined on Firefox */
Function.prototype.safeBind = function() {
  var __method = this, args = $A(arguments), object = args.shift();
  return function() {
	if (typeof $A == 'function')
    return __method.apply(object, args.concat($A(arguments)));
  }
}