React.BackboneMixin={componentDidMount:function(){var e=this.getModel();if(e instanceof Backbone.Collection)e.on("add remove reset sort",function(){this.forceUpdate()},this);else if(e){var t=this.changeOptions||"change";e.on(t,this.onModelChange||function(){this.forceUpdate()},this)}},componentWillUnmount:function(){this.getModel()&&this.getModel().off(null,null,this)}},React.createBackboneClass=function(e){var t=e.mixins||[];return _.extend(e,{mixins:t.concat([React.BackboneMixin]),getModel:function(){return this.props.model},model:function(){return this.getModel()},el:function(){return this._rootNode&&this.getDOMNode()}}),React.createClass(e)};