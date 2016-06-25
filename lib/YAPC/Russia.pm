package YAPC::Russia;

# ABSTRACT: Perl conference YAPC::Russia

=encoding UTF-8

=head1 DESCRIPTION

Here is a simple object that gives data about Perl conference YAPC::Russia.

Module YAPC::Russia uses Semantic Versioning standart for version numbers.
Please visit L<http://semver.org/> to find out all about this great thing.

=cut

use strict;
use warnings FATAL => 'all';
use utf8;
use open qw(:std :utf8);

use Carp;

use Moment;

=head1 METHODS

=cut

=head2 new

    my $yr = YAPC::Russia->new(
        year => 2016,
    );

=cut

sub new {
    my ($class, %params) = @_;

    my $self = {};
    bless $self, $class;

    $self->{_year} = delete $params{year};
    croak 'No "year"' if not defined $self->{_year};

    croak 'Got unknown params: ' . join(', ', keys %params) if %params;

    $self->{_data} = $self->_get_data_for_year($self->{_year});

    return $self;
}

=head2 get_dates

Returns list of L<Moment> objects with dates of the YAPC::Russia event.

    $yr->get_dates();

For the year 2016 it will return objects with dates:

    2016-06-25

=cut

sub get_dates {
    my ($self) = @_;

    my @dates;
    foreach my $d (@{$self->{_data}->{dates}}) {
        push @dates, Moment->new( dt => "$d 00:00:00");
    }

    return @dates;
}

=head2 get_place

Returns hashref with data about place where YAPC::Russia is held.

    $yr->get_place();

For the year 2016 it will return:

    {
        city => 'Moscow',
        name_ru => 'Mail.ru',
        address_ru => 'Ленинградский проспект 39, стр. 79',
        foursquare => 'https://foursquare.com/v/mailru-hq/4b980acdf964a520532835e3',
    }

=cut

sub get_place {
    my ($self) = @_;

    return $self->{_data}->{place};
}

sub _get_data_for_year {
    my ($self, $year) = @_;

    my %data = (
        2014 => {
            dates => [qw(2014-06-13 2014-06-14)],
            place => {
                city => 'Saint Petersburg',
                name_ru => 'Место Роста',
                address_ru => 'Курляндская, дом 5',
                site => 'http://mestorosta.biz',
                phone => '+7 812 648-13-81',
                foursquare => 'https://foursquare.com/v/%D0%BC%D0%B5%D1%81%D1%82%D0%BE-%D1%80%D0%BE%D1%81%D1%82%D0%B0/50fe895ce4b0382948fd8148',
            }
        },
        2015 => {
            dates => [qw(2015-05-16 2015-05-17)],
            place => {
                city => 'Moscow',
                name_ru => 'Mail.ru',
                address_ru => 'Ленинградский проспект 39, стр. 79',
                foursquare => 'https://foursquare.com/v/mailru-hq/4b980acdf964a520532835e3',
            }
        },
        2016 => {
            dates => [qw(2016-06-25)],
            place => {
                city => 'Moscow',
                name_ru => 'Mail.ru',
                address_ru => 'Ленинградский проспект 39, стр. 79',
                foursquare => 'https://foursquare.com/v/mailru-hq/4b980acdf964a520532835e3',
            }
        },
    );

    if (exists $data{$year}) {
        return $data{$year};
    } else {
        croak 'Sorry, no data for year "' . $year . '"';
    }
}

1;
