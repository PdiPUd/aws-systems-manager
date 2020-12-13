## Flat controls: no variables, no aliases
control 'AppDb' do
  title 'MySQL connection'
  describe aws_security_group(group_id: 'sg-066cc7a9ac316cabf', vpc_id: 'vpc-38f5c05e') do
    it { should allow_out(port: 3306, security_group: 'sg-0a9a17095c91eaf77') }
  end
  describe aws_security_group(group_id: 'sg-0a9a17095c91eaf77', vpc_id: 'vpc-38f5c05e') do
    it { should allow_in(port: 3306, security_group: 'sg-066cc7a9ac316cabf') }
  end
end

control 'AppEfs' do
  title 'EFS connection'
  describe aws_security_group(group_id: 'sg-066cc7a9ac316cabf', vpc_id: 'vpc-38f5c05e') do
    it { should allow_out(port: 2049, security_group: 'sg-020bc9292a64de6f9') }
  end
  describe aws_security_group(group_id: 'sg-020bc9292a64de6f9', vpc_id: 'vpc-38f5c05e') do
    it { should allow_in(port: 2049, security_group: 'sg-066cc7a9ac316cabf') }
  end
end

control 'Internet' do
  title 'ALB on internet'
  describe aws_security_group(group_id: 'sg-0e9cbaf20c53fe09a', vpc_id: 'vpc-38f5c05e') do
    it { should allow_in(port: 80, ipv4_range: '0.0.0.0/0') }
  end
end

control 'AlbApp' do
  title 'Connection between the ALB and the application'
  describe aws_security_group(group_id: 'sg-0e9cbaf20c53fe09a', vpc_id: 'vpc-38f5c05e') do
    it { should allow_out(port: 80, security_group: 'sg-066cc7a9ac316cabf') }
  end
  describe aws_security_group(group_id: 'sg-066cc7a9ac316cabf', vpc_id: 'vpc-38f5c05e') do
    it { should allow_in(port: 80, security_group: 'sg-0e9cbaf20c53fe09a') }
  end
end
