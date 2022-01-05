provider "aws" {
  region = "${var.region}"
}

#CREATING A NEW KEY PAIR AND EXPORTING OUR PUBLIC-KEY
resource "aws_key_pair" "key-pair" {
  key_name = "${var.key-name}"
  public_key = "${var.public-key-file-name}"
}

resource "aws_launch_configuration" "launch-configuration" {
  name = "${var.launch-configuration-name}"
  image_id = "${var.image-id}"
  instance_type = "${var.instance-type}"
  security_groups = ["${var.launch-configuration-security-groups}"]
  #Public keyname already attached in AWS Console
  key_name = "${var.launch-configuration-public-key-name}"
}

resource "aws_autoscaling_group" "autoscaling-group" {
  name = "${var.autoscaling-group-name}"
  launch_configuration = "${aws_launch_configuration.launch-configuration.name}"
  max_size = "${var.max-size}"
  min_size = "${var.min-size}"

  tag {
    key = "${var.tag-key}"
    propagate_at_launch = true
    value = "${var.tag-value}"
  }
}
