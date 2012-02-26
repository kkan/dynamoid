require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Dynamoid::Associations::HasAndBelongsToMany" do

  before do
    @subscription = Subscription.create
  end
  
  it 'determines equality from its records' do
    @user = @subscription.users.create
    
    @subscription.users.size.should == 1
    @subscription.users.should include @user
  end

  it 'determines target association correctly' do
    @subscription.users.send(:target_association).should == :subscriptions
  end
  
  it 'determines target attribute' do
    @subscription.users.send(:target_attribute).should == :subscriptions_ids
  end
  
  it 'associates has_and_belongs_to_many automatically' do
    @user = @subscription.users.create
    
    @user.subscriptions.size.should == 1
    @user.subscriptions.should include @subscription
    @subscription.users.size.should == 1
    @subscription.users.should include @user
  end
  
  it 'disassociates has_and_belongs_to_many automatically' do
    @user = @subscription.users.create
    
    @subscription.users.delete(@user)
    @subscription.users.size.should == 0
    @user.subscriptions.size.should == 0
  end
end
