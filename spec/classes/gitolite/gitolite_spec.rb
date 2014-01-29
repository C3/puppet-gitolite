require 'spec_helper'

describe 'gitolite' do

  let(:params) { {
    :keycontent => 'this_is_keycontent',
    :password => 'password_lolz'
  }}

  context 'on debian' do
    let(:facts) { {:operatingsystem => 'debian'} }

    it { should contain_package('bash')           }
    it { should contain_package('git-core')       }
    it { should contain_package('perl')           }
    it { should contain_package('openssh-client') }
  end

  context 'on redhat' do
    let(:facts) { {:operatingsystem => 'redhat'} }

    it { should contain_package('bash')             }
    it { should contain_package('git')              }
    it { should contain_package('perl')             }
    it { should contain_package('openssh-clients')  }
  end

  context 'on other operating systems' do
    let(:facts) { {:operatingsystem => 'random'} }

    it { should contain_package('bash')             }
    it { should contain_package('git')              }
    it { should contain_package('perl')             }
    it { should contain_package('ssh-client')       }
  end

  context 'with no password' do
    let(:params) {{
      :keycontent => 'this_is_keycontent'
    }}

    it do
      expect {
        should compile
      }.to raise_error(Puppet::Error, /password/)
    end
  end
end